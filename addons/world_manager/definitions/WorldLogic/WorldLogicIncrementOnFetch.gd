extends WorldLogic
class_name WorldLogicIncrementOnFetch

@export var KEY := ""

func get_level(data: Dictionary, channel: String) -> World:
	if not data.has(KEY):
		data[KEY] = 0
		
	data[KEY] += 1
		
	return null
