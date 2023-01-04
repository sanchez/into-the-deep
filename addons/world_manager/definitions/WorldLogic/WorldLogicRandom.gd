extends WorldLogic
class_name WorldLogicRandom


@export var CHILDREN: Array[WorldLogic] = []


func get_level(data: Dictionary, channel: String) -> World:
	var index = randi_range(0, CHILDREN.size() - 1)
	return CHILDREN[index].get_level(data, channel)
