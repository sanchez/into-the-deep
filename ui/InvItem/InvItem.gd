extends Panel

export (Array) var INVENTORY
export (int) var SLOT

onready var TextureRectNode := $TextureRect

func get_item():
	#if INVENTORY != null and INVENTORY.size() < SLOT:
	return INVENTORY[SLOT]
	#return null

func _process(_delta):
	var item = get_item()
	if is_instance_valid(item):
		TextureRectNode.texture = item.ICON
	else:
		TextureRectNode.texture = null
