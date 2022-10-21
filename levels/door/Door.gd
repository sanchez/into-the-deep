extends Area2D

signal on_player_entered()


func _on_Area2D_body_entered(body):
	if body is Player:
		emit_signal("on_player_entered")
