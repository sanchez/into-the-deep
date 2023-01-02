extends Node2D
class_name WorldManager

@export var STARTING_WORLD := ""
@export var STARTING_CHANNEL := ""
@export var WORLDS: Array[WorldData] = []

@export var PLAYER: NodePath


var worlds = {}


func find_world(name: String) -> World:
	return worlds[name].SCENE.instantiate()


func load_world(name: String, channel: String):
	var world: World = find_world(name)
	add_child(world)
	
	var spawn = world.find_spawn(channel)
	var player = get_node(PLAYER)
	player.global_position = spawn.global_position
	


func _ready():
	for x in WORLDS:
		worlds[x.NAME] = x
		
	load_world(STARTING_WORLD, STARTING_CHANNEL)
