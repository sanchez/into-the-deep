extends LevelManagerDefinition
class_name LevelManagerWaypoint

export (String) var NAME

func _init():
	resource_local_to_scene = true
	ID = str(randi())
	print("LevelManagerWaypoint: ", ID)

func generate_id():
	ID = str(randi())
	print("LevelManagerWaypoint: ", ID)
