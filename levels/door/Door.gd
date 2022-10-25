extends LevelManagerDoor

export (Array, NodePath) var LOCKED_BY
export (Resource) var LINKS_TO

signal on_player_entered()

func is_locked():
	for x in LOCKED_BY:
		if has_node(x):
			return true
	return false

func _on_Area2D_body_entered(body):
	if body is Player:
		if not is_locked():
			var next_level = LINKS_TO.get_level()
			emit_signal("on_player_entered", next_level)
