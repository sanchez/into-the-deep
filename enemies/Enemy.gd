extends KinematicBody2D
class_name Enemy

export (Resource) var MOVEMENT
export (Resource) var TARGETER

var APPLY_ROTATION = true

var motion := Vector2.ZERO

func _process(delta):
	var target = TARGETER.locate(self, delta)
	MOVEMENT.move_towards(target, self, delta)

func on_death():
	queue_free()
