extends KinematicBody2D
class_name Enemy

var SEARCH_RANGE = 200
var ACCELERATION = 300
var MAX_SPEED = 70
var FRICTION = 7.0

var motion := Vector2.ZERO

var last_target = Vector2.ZERO

func get_target(world: BaseWorld) -> Vector2:
	var players = world.get_players()
	var closest_player = Utils.find_closest_node(get_position(), players)
	
	if last_target == null:
		get_new_random_location()
		
	if closest_player == null:
		return last_target
	
	return closest_player.global_position

func get_new_random_location():
	var search_vect = Vector2(rand_range(-1, 1), rand_range(-1, 1)).normalized() * SEARCH_RANGE
	var new_target = search_vect + global_position
	last_target = new_target

func get_position():
	return global_position

func _process(delta):
	if owner is BaseWorld:
		think(delta, owner)
		
func move_towards(target: Vector2, delta: float):
	var inputVector = (target - global_position).normalized()
	var new_motion = motion + (inputVector * ACCELERATION * delta)
	new_motion = new_motion.limit_length(MAX_SPEED)
	rotation = inputVector.angle() + (PI / 2)
	motion = move_and_slide(new_motion)

func think(_delta: float, _level: BaseWorld):
	pass
