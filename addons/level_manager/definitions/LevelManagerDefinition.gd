extends Resource
class_name LevelManagerDefinition

export (Vector2) var POSITION
export (String) var ID

func _init():
	ID = str(randi())
