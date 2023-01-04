extends Node2D
class_name WorldManager

@export var STARTING_WORLD := ""
@export var STARTING_CHANNEL := ""
@export var WORLDS: Array[WorldLogicContainer] = []

@export var PLAYER: NodePath


var world_data = {}
var current_world: World


func _find_world(name: String, channel: String) -> World:
	for x in WORLDS:
		if x.NAME == name:
			return x.get_level(world_data, channel)
	return null


func _load_world(name: String, channel: String):
	current_world = _find_world(name, channel)
	add_child(current_world)
	
	if has_node(PLAYER):
		var spawn = current_world.find_spawn(channel)
		var player = get_node(PLAYER)
		player.global_position = spawn.global_position
	
	
func _clear_world():
	for x in get_children():
		if x is World:
			x.queue_free()
	
	
func _set_world(name: String, channel: String):
	_clear_world()
	_load_world(name, channel)
	

func set_world(name: String, channel: String):
	call_deferred("_set_world", name, channel)


func _ready():
	set_world(STARTING_WORLD, STARTING_CHANNEL)
