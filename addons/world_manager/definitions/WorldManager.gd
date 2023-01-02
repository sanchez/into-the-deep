extends Node2D
class_name WorldManager

@export var STARTING_WORLD := ""
@export var STARTING_CHANNEL := ""
@export var WORLDS: Array[WorldData] = []

@export var PLAYER: NodePath


var worlds = {}
var current_world: World


func find_world(name: String) -> World:
	return worlds[name].SCENE.instantiate()


func load_world(name: String, channel: String):
	current_world = find_world(name)
	add_child(current_world)
	
	if has_node(PLAYER):
		var spawn = current_world.find_spawn(channel)
		var player = get_node(PLAYER)
		player.global_position = spawn.global_position
	
	
func clear_world():
	for x in get_children():
		if x is World:
			x.queue_free()
	
	
func set_world(name: String, channel: String):
	clear_world()
	load_world(name, channel)
	
	
func next_world(channel: String):
	pass


func _ready():
	for x in WORLDS:
		worlds[x.NAME] = x
		
	set_world(STARTING_WORLD, STARTING_CHANNEL)
