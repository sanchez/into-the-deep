extends Area2D

signal on_hit(item)
signal on_finish()

func _handle_end():
	queue_free()
	emit_signal("on_finish")

func _on_BaseAOE_body_entered(body):
	emit_signal("on_hit", body)
