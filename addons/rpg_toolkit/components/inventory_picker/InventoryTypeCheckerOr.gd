extends InventoryTypeChecker
class_name ITC_Or

@export var CHILDREN: Array[InventoryTypeChecker] = []

func is_allowed(item) -> bool:
	for x in CHILDREN:
		if x.is_allowed(item):
			return true
	return false
