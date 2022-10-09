extends Panel

const DefaultInvItemStyle := preload("res://ui/InvItem/DefaultInvItemStyle.tres")
const SelectedInvItemStyle := preload("res://ui/InvItem/SelectedInvItemStyle.tres")

signal on_item_selected(slot)

export (Array) var INVENTORY
export (int) var SLOT

export (bool) var ONLY_WEAPON = false
export (bool) var ONLY_ARTIFACT = false

onready var TextureRectNode := $TextureRect

func get_item():
	#if INVENTORY != null and INVENTORY.size() < SLOT:
	return INVENTORY[SLOT]
	#return null
	
func set_selected(selected):
	if selected:
		add_stylebox_override("panel", SelectedInvItemStyle)
	else:
		add_stylebox_override("panel", DefaultInvItemStyle)
		
func _ready():
	set_selected(false)

func _process(_delta):
	var item = get_item()
	if is_instance_valid(item):
		TextureRectNode.texture = item.ICON
	else:
		TextureRectNode.texture = null

func _on_InvItem_gui_input(event):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == BUTTON_LEFT:
			set_selected(true)
			emit_signal("on_item_selected")
