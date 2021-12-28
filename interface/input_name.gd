extends HBoxContainer


signal venv_change(path)


func get_name() -> String:
	return $name.get_text()


func set_name(name: String):
	$name.set_text(name)


func get_venv():
	return $Setting.get_choice()


func _on_Setting_venv_change(path):
	emit_signal("venv_change", path)
