extends LevelManagerWorld

onready var BasePlayerNode := $BasePlayer

var current_level = 0
var current_stage = 0

func load_world(world: PackedScene):
	var instance = world.instance()
	instance.connect("on_next_level", self, "_handle_next_level")
	instance.add_to_group("level")
	
	add_child(instance)
	var player_spawn_pos = instance.get_player_spawn()
	BasePlayerNode.global_position = player_spawn_pos

func load_level():
	if current_level == 0:
		load_overworld()
		pass
	
	var level = LEVELS[current_level - 1]
	var stage = level.get_level(current_stage)
	if not is_instance_valid(stage):
		# TODO: Go to the next stage/level/home
		return
		
	load_world(stage)
	
func deferred_next_level(world: PackedScene):
	current_stage += 1
	for x in get_children():
		if x.is_in_group("level"):
			x.queue_free()
	
	load_world(world)
	
func _handle_next_level(world):
	call_deferred("deferred_next_level", world)

func _ready():
	load_overworld()
