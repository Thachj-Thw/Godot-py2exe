extends VBoxContainer


export(String) var text
enum MODE {OPEN_FILE, OPEN_FOLDER}
export(MODE) var mode = MODE.OPEN_FILE
export(PoolStringArray) var types

onready var file_dialog := $Anchor/FileDialog
onready var write_path := $HBoxContainer/Path

signal path_selected(path)
signal path_writing(path)


func _ready():
	$Title.set_text(text)
	match mode:
		MODE.OPEN_FILE:
			file_dialog.set_filters(types)
			file_dialog.window_title = "Choose a file"
			file_dialog.set_mode(FileDialog.MODE_OPEN_FILE)
		MODE.OPEN_FOLDER:
			file_dialog.window_title = "Choose a folder"
			file_dialog.set_mode(FileDialog.MODE_OPEN_DIR)


func _on_OpenFile_pressed():
	file_dialog.popup_centered()


func _on_FileDialog_dir_selected(dir):
	write_path.set_text(dir)
	emit_signal("path_selected", dir)


func _on_FileDialog_file_selected(path):
	write_path.set_text(path)
	emit_signal("path_selected", path)


func get_selected() -> String:
	return write_path.get_text()


func set_path(path: String):
	write_path.set_text(path)


func _on_Path_text_changed(new_text):
	emit_signal("path_writing", new_text)
