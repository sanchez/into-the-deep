extends Node2D

export (PackedScene) var PLAYER
export (Array, Resource) var LEVELS

var current_level = 0
var current_stage = 0

func load_level(player):
	var level = LEVELS[current_level]
	var stage = level.get_level(current_stage)
	if not is_instance_valid(stage):
		# TODO: Go to the next stage/level/home
		return
		
	var stage_instance = stage.instance()
	stage_instance.connect("on_next_level", self, "_handle_next_level")
	add_child(stage_instance)
	stage_instance.spawn_player(player)
	
func deferred_next_level(player):
	current_stage += 1
	for x in get_children():
		remove_child(x)
	
	load_level(player)
	
func _handle_next_level(player):
	call_deferred("deferred_next_level", player)

func _ready():
	var player_instance = PLAYER.instance()
	load_level(player_instance)
