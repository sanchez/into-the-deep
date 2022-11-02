extends LevelManagerDefinition
class_name LevelManagerLevel

export (String) var FILE_PATH

func _init():
	resource_local_to_scene = true
	ID = str(randi())
	print("LevelManagerLevel: ", ID)

func generate_id():
	ID = str(randi())
	print("LevelManagerLevel: ", ID)
