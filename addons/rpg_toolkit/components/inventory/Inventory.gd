extends Area2D
class_name Inventory

@export var SLOTS: Array[InventorySlot] = []


func try_add(item: InvItem):
	for x in SLOTS:
		if x.try_stack(item):
			return true
	
	return false


func _on_area_entered(area):
	if area is InvItem:
		if try_add(area):
			area.get_parent().remove_child(area)


func get_item_in_slot(slot: int) -> InvItem:
	if slot >= SLOTS.size():
		return null
		
	var invItem = SLOTS[slot].ITEM
	return invItem
