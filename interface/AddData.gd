extends VBoxContainer


onready var all_data := $HBoxContainer/All
onready var data_add := $HBoxContainer/Add


func set_data(path):
	all_data.clear()
	data_add.clear()
	for f in listdir(path):
		all_data.add_item(f)


func get_add() -> Array:
	var add : Array = []
	for i in range(data_add.get_item_count()):
		add.append(data_add.get_item_text(i))
	return add


func listdir(path: String) -> Array:
	var files : Array = []
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin()
	var file = dir.get_next()
	while file != "":
		if not file.begins_with("."):
			files.append(file)
		file = dir.get_next()
	dir.list_dir_end()
	return files


func _on_Button_pressed():
	var idxs : Array = all_data.get_selected_items()
	for idx in idxs:
		data_add.add_item(all_data.get_item_text(idx))
	for idx in idxs:
		all_data.remove_item(idx)
	if idxs and all_data.get_item_count() > 0:
		all_data.select(idxs[0])


func _on_Button2_pressed():
	var idxs : Array = data_add.get_selected_items()
	for idx in idxs:
		all_data.add_item(data_add.get_item_text(idx))
	for idx in idxs:
		data_add.remove_item(idx)
	if idxs and data_add.get_item_count() > 0:
		data_add.select(idxs[0])
