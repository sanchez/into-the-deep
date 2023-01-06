extends Resource
class_name InventorySlot


@export var ITEM: InvItem
@export var CONSTRAINT: InventoryTypeChecker


func has_item():
	return is_instance_valid(ITEM)


func can_place(item: InvItem):
	if is_instance_valid(CONSTRAINT):
		return CONSTRAINT.is_allowed(item)
	
	return false


func try_stack(item: InvItem):
	if not can_place(item):
		return false
		
	if has_item():
		return ITEM.try_stack(item)
		
	ITEM = item
		
	return false
