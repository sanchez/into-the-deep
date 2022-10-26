tool
extends GraphEdit

const LevelNode := preload("res://addons/level_manager/ui/controls/LevelNode.tscn")

func can_drop_data(position, data):
	var file_paths = data["files"]
	for x in file_paths:
		if not x.ends_with(".tscn"):
			return false
	return true
	
func add_file(path, position):
	var level_node = LevelNode.instance()
	level_node.FILE_PATH = path
	level_node.offset = position
	add_child(level_node)

func drop_data(position, data):
	var file_paths = data["files"]
	for path in file_paths:
		call_deferred("add_file", path, position)
