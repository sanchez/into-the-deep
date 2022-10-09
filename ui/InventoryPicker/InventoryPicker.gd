extends CanvasLayer

export (NodePath) var INVENTORY_PATH

const InvItem := preload("res://ui/InvItem/InvItem.tscn")

onready var TopRowNode := $Control/ColorRect2/MarginContainer/VBoxContainer/TopRow
onready var StoredNode := $Control/ColorRect2/MarginContainer/VBoxContainer/Stored

onready var WeaponNode := $Control/ColorRect2/MarginContainer/VBoxContainer/TopRow/Weapon

var show_inventory = false
var selected_slot = null

func bind_inv_slot_handlers(slot):
	slot.connect("on_item_selected", self, "handle_item_selected", [slot])
	
func can_input_item(slot, item) -> bool:
	if not is_instance_valid(item):
		return true
		
	if slot.ONLY_WEAPON:
		if not item is Weapon:
			return false
			
	if slot.ONLY_ARTIFACT:
		if not item is Artifact:
			return false
			
	return true
	
func handle_item_selected(slot):
	if is_instance_valid(selected_slot):
		# swap the slots
		
		var a = slot.get_item()
		var b = selected_slot.get_item()
		
		if can_input_item(slot, b) and can_input_item(selected_slot, a):
			slot.INVENTORY[slot.SLOT] = b
			selected_slot.INVENTORY[selected_slot.SLOT] = a
		
		slot.set_selected(false)
		selected_slot.set_selected(false)
		selected_slot = null
	else:
		selected_slot = slot

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
	bind_inv_slot_handlers(WeaponNode)
	
	for x in range(0, artifact_slots):
		var invItem = InvItem.instance()
		invItem.INVENTORY = inventory.EQUIPPED_ARTIFACTS
		invItem.SLOT = x
		invItem.ONLY_ARTIFACT = true
		bind_inv_slot_handlers(invItem)
		TopRowNode.add_child(invItem)
	
	var spare_slots = inventory.MAX_SPARE_SLOTS
	for x in range(0, spare_slots):
		var invItem = InvItem.instance()
		invItem.INVENTORY = inventory.spare_slots
		invItem.SLOT = x
		bind_inv_slot_handlers(invItem)
		StoredNode.add_child(invItem)
		
func close():
	show_inventory = false
	visible = show_inventory
	if is_instance_valid(selected_slot):
		selected_slot.set_selected(false)
	selected_slot = null

func _input(event):
	if event.is_action_pressed("inventory"):
		show_inventory = not show_inventory
		#owner.get_tree().paused = show_inventory
		visible = show_inventory
		if not show_inventory:
			if is_instance_valid(selected_slot):
				selected_slot.set_selected(false)
			selected_slot = null

#func _process(_delta):
	#if is_instance_valid(selected_slot):
	#	var item = selected_slot.get_item()
	#	if is_instance_valid(item):
	#		HoverItemNode.texture = item.ICON
	#	else:
	#		HoverItemNode.texture = null
	#	HoverItemNode.visible = true
	#else:
	#	HoverItemNode.visible = false


func _on_ColorRect_gui_input(event):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == BUTTON_LEFT:
			close()
