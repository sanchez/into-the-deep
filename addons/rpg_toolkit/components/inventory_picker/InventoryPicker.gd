extends Node


var inventory: Inventory

# Called when the node enters the scene tree for the first time.
func _ready():
	var parent = get_parent()
	if parent is Inventory:
		inventory = parent
	else:
		push_error("Parent item in tree needs to be inventory")


func _input(event):
	if event.is_action_pressed("inventory"):
		pass
