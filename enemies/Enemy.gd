extends KinematicBody2D
class_name Enemy

var ACCELERATION = 300
var MAX_SPEED = 70
var FRICTION = 7.0

var motion := Vector2.ZERO

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

func think(delta: float, level: BaseWorld):
	pass
