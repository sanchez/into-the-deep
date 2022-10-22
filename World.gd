extends Node2D

export (Array, Resource) var LEVELS

onready var BasePlayerNode := $BasePlayer

var current_level = 0
var current_stage = 0

func load_level():
	var level = LEVELS[current_level]
	var stage = level.get_level(current_stage)
	if not is_instance_valid(stage):
		# TODO: Go to the next stage/level/home
		return
		
	var stage_instance = stage.instance()
	stage_instance.connect("on_next_level", self, "_handle_next_level")
	stage_instance.add_to_group("level")
	
	var player_spawn_pos = stage_instance.get_player_spawn()
	BasePlayerNode.global_position = player_spawn_pos
	
	add_child(stage_instance)
	
func deferred_next_level():
	current_stage += 1
	for x in get_children():
		if x.is_in_group("level"):
			x.queue_free()
	
	load_level()
	
func _handle_next_level():
	call_deferred("deferred_next_level")

func _ready():
	load_level()
