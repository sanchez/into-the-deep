extends Resource
class_name LevelManagerDefinition

export (Vector2) var POSITION
export (Array, String) var ID = get_instance_id()
export (Array, Resource) var CHILDREN


func next_level():
	var index = randi() % CHILDREN.size()
	return CHILDREN[index]


func load_level():
	return null
