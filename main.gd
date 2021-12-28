extends Control


onready var NAME := $VBoxContainer/Name
onready var IN_PATH := $VBoxContainer/Input
onready var OUT_PATH := $VBoxContainer/Output
onready var OPTIONS := $VBoxContainer/Options
onready var ICON := $VBoxContainer/Icon
onready var ADD := $VBoxContainer/AddData
onready var BUTTON := $VBoxContainer/Control/Convert
onready var ANIMATION := $VBoxContainer/Control/Convert/AnimationPlayer

var thread = Thread.new()
var pyw : String = "pythonw"
var converter : String = "pyinstaller"


func _ready():
	set_version()


func set_version():
	var output : Array = []
	var err : bool = OS.execute(pyw, ["actions/version.pyw"], true, output)
	if err:
		$Version.set("custom_colors/font_color", Color(.86, 0, 0))
		$Version.set_text("PyInstaller not found")
	else:
		$Version.set("custom_colors/font_color", Color(.86, .86, .86))
		var ver = output[0]
		ver.erase(len(ver) -1, 1)
		$Version.set_text("PyInstaller Version " + ver)
		print("Change version Pyinstaller to " + ver)


func start_convert(command: String):
#	print(command)
	print("Convertting")
	write_file(command)
	thread = Thread.new()
	thread.start(self, "_thread_convert")


func _thread_convert(_userdata):
	ANIMATION.play("convert")
	var output_cvt : Array = []
	var err : bool = OS.execute(pyw, ["actions/convert.pyw"], true, output_cvt, true)
	if err:
		ANIMATION.play("Fail")
		OS.alert("Convert Fail!\n" + output_cvt[0], "ERROR")
		print("Convert Fail!\n" + output_cvt[0])
	else:
		ANIMATION.play("Successfully")
		OS.alert("Convert Successfully!", "Successfully")
		print("Convert Successfully!")


func _exit_tree():
	thread.wait_to_finish()


func write_file(text: String):
	var file = File.new()
	file.open("actions/.brg", File.WRITE)
	file.store_line(text)
	file.close()


func _on_Convert_pressed():
	var _name : String = NAME.get_name()
	var in_path : String = IN_PATH.get_selected()
	var out_path : String = OUT_PATH.get_selected()
	var options : Array = OPTIONS.get_options()
	var icon_path : String = ICON.get_icon_path()
	var add : Array = ADD.get_add()
	if not _name:
		OS.alert("Name must'n be empty", "Name")
		return
	if not in_path:
		OS.alert("Path must'n be empty", "Input File")
		return
	if not out_path:
		OS.alert("Path must'n be empty", "Output Folder")
		return
	if not icon_path:
		OS.alert("Path must'n be empty", "Icon")
		return
	
	var args : Array = []
	if options[0]:
		args.append("--onefile")
	if options[1]:
		args.append("--noconsole")
	if options[2]:
		args.append("--uac-admin")
	var command : Dictionary = {
		"converter": converter,
		"name": _name,
		"distpath": out_path,
		"script": in_path,
		"icon": icon_path,
		"data": add,
		"options": args
	}
	start_convert(JSON.print(command))


func _on_Input_path_selected(path):
	if not NAME.get_name():
		NAME.set_name(path.get_file().get_basename())
	if not OUT_PATH.get_selected():
		OUT_PATH.set_path(path.get_base_dir())
	ADD.set_data(path.get_base_dir())
	if path.get_extension() == "pyw":
		OPTIONS.windowed_block(true)
	else:
		OPTIONS.windowed_block(false)


func _on_Input_path_writing(path):
	if path.get_extension():
		if not NAME.get_name():
			NAME.set_name(path.get_file().get_basename())
		if not OUT_PATH.get_selected():
			OUT_PATH.set_path(path.get_base_dir())
		ADD.set_data(path.get_base_dir())
		if path.get_extension() == "pyw":
			OPTIONS.windowed_block(true)
		else:
			OPTIONS.windowed_block(false)


func _on_Name_venv_change(path: String):
	if path == "PATH":
		pyw = "pythonw"
		converter = "pyinstaller"
	else:
		pyw = path.plus_file("scripts").plus_file("pythonw.exe")
		converter = path.plus_file("scripts").plus_file("pyinstaller.exe")
	set_version()
