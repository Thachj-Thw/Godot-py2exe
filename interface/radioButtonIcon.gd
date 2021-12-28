extends VBoxContainer


onready var lable_path := $HBoxContainer/Label
onready var input_path := $HBoxContainer/LineEdit
onready var button := $HBoxContainer/Button
onready var file_dialog := $HBoxContainer/Control/FileDialog


func disable_input_option():
	lable_path.set("custom_colors/font_color", Color(.5, .5, .5))
	input_path.set_editable(false)
	button.set_disabled(true)


func enable_input_option():
	lable_path.set("custom_colors/font_color", Color(.86, .86, .86))
	input_path.set_editable(true)
	button.set_disabled(false)


func _on_Button_pressed():
	file_dialog.popup_centered()


func _on_Default_pressed():
	disable_input_option()


func _on_None_pressed():
	disable_input_option()


func _on_Option_pressed():
	enable_input_option()


func _on_FileDialog_file_selected(path):
	input_path.set_text(path)
