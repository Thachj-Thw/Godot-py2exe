extends VBoxContainer


onready var file_dialog := $HBoxContainer/Button/FileDialog
onready var line_edit := $HBoxContainer/LineEdit


func _ready():
	disable_inpath(true)


func disable_inpath(dis: bool):
	line_edit.set_editable(not dis)
	$HBoxContainer/Button.set_disabled(dis)
	if dis:
		$HBoxContainer/TitlePath.set("custom_colors/font_color", Color(.5, .5, .5))
	else:
		$HBoxContainer/TitlePath.set("custom_colors/font_color", Color(.86, .86, .86))


func _on_Default_pressed():
	disable_inpath(true)


func _on_Virtual_pressed():
	disable_inpath(false)


func _on_Button_pressed():
	file_dialog.popup_centered()


func _on_FileDialog_dir_selected(dir):
	line_edit.set_text(dir)
