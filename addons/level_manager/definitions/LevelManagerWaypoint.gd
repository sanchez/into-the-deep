extends LevelManagerDefinition
class_name LevelManagerWaypoint


export (String) var NAME


var selected_level = null


func find_next_level():
	var index = randi() % CHILDREN.size()
	selected_level = CHILDREN[index]
	

func next_level():
	if not is_instance_valid(selected_level):
		find_next_level()


func load_level():
	return next_level().load_level()
