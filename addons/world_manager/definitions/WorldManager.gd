extends Node2D
class_name WorldManager

@export var STARTING_WORLD := ""
@export var STARTING_CHANNEL := ""
@export var WORLDS: Array[WorldLogicContainer] = []

@export var PLAYER: NodePath


var world_data = {}
var current_world: World


func _find_world(name: String, channel: String) -> World:
	print("World Data: ", JSON.stringify(world_data))
	for x in WORLDS:
		if x.NAME == name:
			return x.get_level(world_data, channel)
	return null


func _load_world(name: String, channel: String):
	print("Loading World: ", name)
	current_world = _find_world(name, channel)
	
	if has_node(PLAYER):
		var spawn = current_world.find_spawn(channel)
		var player = get_node(PLAYER)
		player.global_position = spawn.global_position
		
	# This is required so the old events and positions are updated before new events are fired
	await get_tree().create_timer(0.1).timeout
	add_child.call_deferred(current_world)
	
	
func _clear_world():
	for x in get_children():
		if x is World:
			x.queue_free()
	
	
func _set_world(name: String, channel: String):
	_clear_world()
	OS.delay_msec(100)
	_load_world(name, channel)
	

func set_world(name: String, channel: String):
	call_deferred("_set_world", name, channel)


func _ready():
	set_world(STARTING_WORLD, STARTING_CHANNEL)
