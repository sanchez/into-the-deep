extends EnemyMovement
class_name EMMoveTowards

export (float) var ACCELERATION = 300.0
export (float) var MAX_SPEED = 70.0
export (float) var FRICTION = 7.0

func move_towards(position: Vector2, enemy: Enemy, delta: float):
	var inputVector = (position - enemy.global_position).normalized()
	var new_motion = enemy.motion + (inputVector * ACCELERATION * delta)
	new_motion = new_motion.limit_length(MAX_SPEED)
	enemy.global_rotation = inputVector.angle() + (PI / 2)
	enemy.motion = enemy.move_and_slide(new_motion)
