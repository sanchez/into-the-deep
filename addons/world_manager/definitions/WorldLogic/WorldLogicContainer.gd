extends WorldLogic
class_name WorldLogicContainer

@export var NAME := ""
@export var CHILDREN: Array[WorldLogic] = []

func get_level(data: Dictionary, channel: String) -> World:
	for x in CHILDREN:
		var res = x.get_level(data, channel)
		if is_instance_valid(res):
			return res
	return null
