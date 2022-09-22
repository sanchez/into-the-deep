extends KinematicBody2D

export (int) var ACCELERATION = 600
export (int) var MAX_SPEED = 128
export (float) var FRICTION = 0.1

var motion := Vector2.ZERO

func _physics_process(delta):
	var inputVector = get_input()
	motion = apply_motion(inputVector, delta)
	motion = apply_friction(inputVector)
	
	apply_rotation(inputVector)
	
	move()
	
func apply_rotation(inputVector: Vector2):
	if inputVector.length_squared() > 0:
		rotation = inputVector.angle() + (PI / 2)
	
func apply_motion(inputVector: Vector2, delta: float):
	var newMotion = motion + (inputVector * ACCELERATION * delta)
	return newMotion.clamped(MAX_SPEED)
	
func apply_friction(inputVector: Vector2):
	if inputVector.length_squared() == 0:
		return motion.slerp(Vector2.ZERO, FRICTION)
	return motion
	
func get_input():
	var inputVector = Vector2.ZERO
	
	inputVector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	inputVector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	return inputVector.limit_length(1)
	
func move():
	motion = move_and_slide(motion)
