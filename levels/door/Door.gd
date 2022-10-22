extends Area2D

export (Array, NodePath) var LOCKED_BY

signal on_player_entered()

func is_locked():
	for x in LOCKED_BY:
		if has_node(x):
			return true
	return false

func _on_Area2D_body_entered(body):
	if body is Player:
		if not is_locked():
			emit_signal("on_player_entered")
