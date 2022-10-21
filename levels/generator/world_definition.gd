extends Resource
class_name WorldDefinition

export (Array, Resource) var LEVELS

func get_level(stage: int) -> PackedScene:
	var possible_levels = []
	
	for x in LEVELS:
		if stage >= x.MIN_STAGE and stage <= x.MAX_STAGE:
			possible_levels.append(x.STAGE)
			
	# we don't have anymore levels so go back or next stage
	if possible_levels.size() < 1:
		return null
			
	var rand_index = randi() % possible_levels.size()
	return possible_levels[rand_index]
