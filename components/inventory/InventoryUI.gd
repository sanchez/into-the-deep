extends Node2D

export (NodePath) var INVENTORY_PATH

var show_inventory = false

func get_inventory():
	var node = get_node(INVENTORY_PATH)
	for x in node.get_children():
		if x is Inventory:
			return x
	return null

func render_inventory_toolbar(inventory: Inventory):
	pass
	
func render_inventory_picker(inventory: Inventory):
	pass

func _process(delta):
	global_position = Vector2.ZERO
	global_rotation = 0
	global_scale = Vector2.ONE
	
	if Input.is_action_just_pressed("inventory"):
		show_inventory = not show_inventory
		
	var inventory = get_inventory()
	if inventory == null:
		return
	
	if show_inventory:
		render_inventory_picker(inventory)
	render_inventory_toolbar(inventory)
