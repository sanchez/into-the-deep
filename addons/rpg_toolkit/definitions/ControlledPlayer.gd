extends CharacterBody2D
class_name ControlledPlayer

@export var MAX_SPEED := 300.0
@export var ACCELERATION := 100.0
@export var FRICTION := 0.8


func _physics_process(delta):
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	velocity = velocity.slerp(Vector2.ZERO, FRICTION)
	
	if direction.length_squared() > 0.0001:
		var new_velocity = direction * ACCELERATION + velocity
		velocity += new_velocity
	
	move_and_slide()
