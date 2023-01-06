extends InventoryTypeChecker
class_name WeaponTypeChecker

func is_allowed(item) -> bool:
	if item is WeaponInvItem:
		return true
	return false
