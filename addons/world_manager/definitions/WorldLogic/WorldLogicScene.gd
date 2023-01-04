extends WorldLogic
class_name WorldLogicScene

@export var WORLD: PackedScene

func get_level(data: Dictionary, channel: String) -> World:
	return WORLD.instantiate()
