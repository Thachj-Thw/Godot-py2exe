extends HBoxContainer


func get_options() -> Array:
	return [$OneFile.is_pressed(), $Windowed.is_pressed(), $Admin.is_pressed()]


func windowed_block(mode: bool):
	$Windowed.set_disabled(mode)
	if mode:
		$Windowed.set_pressed(true)
