extends CanvasLayer

export (NodePath) var INVENTORY_PATH

const InvItem := preload("res://ui/InvItem/InvItem.tscn")

onready var TopRowNode := $Control/ColorRect2/MarginContainer/VBoxContainer/TopRow
onready var StoredNode := $Control/ColorRect2/MarginContainer/VBoxContainer/Stored

onready var WeaponNode := $Control/ColorRect2/MarginContainer/VBoxContainer/TopRow/Weapon

var show_inventory = false

func get_inventory_player():
	var inventory = get_node(INVENTORY_PATH)
	if is_instance_valid(inventory):
		return inventory
		
	var parent = get_parent()
	if "INVENTORY_PATH" in parent:
		inventory = parent.get_node(parent.INVENTORY_PATH)
		if is_instance_valid(inventory):
			return inventory
			
	return null

func get_inventory() -> Inventory:
	var inventory_node = get_inventory_player()
	if not is_instance_valid(inventory_node):
		return null
		
	if inventory_node is Inventory:
		return inventory_node
		
	for x in inventory_node.get_children():
		if x is Inventory:
			return x
			
	return null

func _ready():
	var inventory = get_inventory()
	if not is_instance_valid(inventory):
		return
	
	var artifact_slots = inventory.MAX_ARTIFACT_SLOTS
	TopRowNode.columns = artifact_slots + 2
	StoredNode.columns = artifact_slots + 2
	
	WeaponNode.INVENTORY = inventory.EQUIPPED_WEAPON
	WeaponNode.SLOT = 0
	
	for x in range(0, artifact_slots):
		var invItem = InvItem.instance()
		invItem.INVENTORY = inventory.EQUIPPED_ARTIFACTS
		invItem.SLOT = x
		TopRowNode.add_child(invItem)
	
	var spare_slots = inventory.MAX_SPARE_SLOTS
	for x in range(0, spare_slots):
		var invItem = InvItem.instance()
		invItem.INVENTORY = inventory.spare_slots
		invItem.SLOT = x
		StoredNode.add_child(invItem)

func _input(event):
	if event.is_action_pressed("inventory"):
		show_inventory = not show_inventory
		#owner.get_tree().paused = show_inventory
		visible = show_inventory
