extends Node


var health: Health

# Called when the node enters the scene tree for the first time.
func _ready():
	var parent = get_parent()
	if parent is Health:
		health = parent
	else:
		push_error("Failed to find health class for health bar")
