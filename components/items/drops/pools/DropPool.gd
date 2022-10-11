extends Resource
class_name DropPool

export (Array, Resource) var POSSIBLE_DROPS

func get_drop():
	var index = randi() % POSSIBLE_DROPS.size()
	return POSSIBLE_DROPS[index]
