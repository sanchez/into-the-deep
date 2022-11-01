extends Resource
class_name LevelManagerDefinition

export (Vector2) var POSITION
export (String) var ID

func _init():
	resource_local_to_scene = true
	ID = str(randi())
	print("LevelManagerDefinition: ", ID)

func generate_id():
	ID = str(randi())
	print("LevelManagerDefinition: ", ID)
