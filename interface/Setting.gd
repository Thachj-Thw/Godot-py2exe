extends Button


onready var default := $PopupDialog/VBoxContainer/VBoxContainer/Default
onready var venv := $PopupDialog/VBoxContainer/VBoxContainer/Virtual
onready var popup := $PopupDialog/VBoxContainer/VBoxContainer
onready var line_edit := $PopupDialog/VBoxContainer/VBoxContainer/HBoxContainer/LineEdit

var choice_default : bool = true

signal venv_change(path)


func get_choice():
	if default.is_pressed():
		return "PATH"
	return line_edit.get_text()


func _on_Setting_pressed():
	$PopupDialog.popup_centered()


func _on_Close_pressed():
	$PopupDialog.set_visible(false)
	if choice_default:
		default.set_pressed(true)
		popup.disable_inpath(true)
	else:
		venv.set_pressed(true)
		popup.disable_inpath(false)


func _on_Ok_pressed():
	$PopupDialog.set_visible(false)
	if not line_edit.get_text():
		default.set_pressed(true)
		popup.disable_inpath(true)
	emit_signal("venv_change", get_choice())


func _on_PopupDialog_about_to_show():
	choice_default = default.is_pressed()
