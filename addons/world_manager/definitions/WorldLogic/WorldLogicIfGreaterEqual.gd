extends WorldLogic
class_name WorldLogicIfGreaterEqual

@export var KEY := ""
@export var VALUE := 4
@export var CHILD: WorldLogic

func get_level(data: Dictionary, channel: String) -> World:
	if data.has(KEY) and data[KEY] >= VALUE:
		return CHILD.get_level(data, channel)
	return null
