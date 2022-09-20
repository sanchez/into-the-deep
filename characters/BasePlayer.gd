extends KinematicBody2D

export (int) var ACCELERATION = 512
export (int) var MAX_SPEED = 64
export (float) var FRICTION = 0.25

var motion := Vector2.ZERO

func _physics_process(delta):
	var inputVector = get_input();
	motion += inputVector * ACCELERATION * delta
	motion.x = clamp(motion.x, -MAX_SPEED, MAX_SPEED)
	if inputVector.x == 0:
		motion.x = lerp(motion.x, 0, FRICTION)
	
	move()
	
func get_input():
	var inputVector = Vector2.ZERO
	
	inputVector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	return inputVector
	
func move():
	motion = move_and_slide(motion)
