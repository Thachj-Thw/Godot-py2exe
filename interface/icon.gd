extends Control


onready var file_path := $HBoxContainer/VBoxContainer/HBoxContainer/LineEdit


func get_icon_path() -> String:
	if $HBoxContainer/VBoxContainer/Default.is_pressed():
		return "DEFAULT"
	elif $HBoxContainer/VBoxContainer/None.is_pressed():
		return "NONE"
	return file_path.get_text()
