extends Node2D
class_name LevelManagerWorld

export (Resource) var LEVEL

var current_level = null

func _ready():
	pass

func load_next(from_channel):
	if not is_instance_valid(current_level):
		current_level = LEVEL.get_start_waypoint_node()
		
	var next_connection = LEVEL.get_next_level(current_level.ID, from_channel)
	
	var next_channel = next_connection.TO_CHANNEL
	var next_level = LEVEL.load_level_from_id()
