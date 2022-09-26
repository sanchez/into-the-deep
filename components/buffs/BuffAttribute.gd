extends Resource
class_name BuffAttribute

func on_apply(_buff, _health):
	pass
	
func on_remove(_buff, _health):
	pass
	
func on_damage(_buff, _health, _damage):
	pass
	
func on_attack(_buff, _health):
	return true
	
func on_ability(_buff):
	return true
	
func on_tick(_buff, _health, _delta: float):
	pass

func on_stack_changed(_buff, _health):
	pass
