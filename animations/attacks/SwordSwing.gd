extends Area2D

signal on_hit(item)

func _on_SwordSwing_area_entered(area):
	emit_signal("on_hit", area)
