extends Resource
class_name ItemTrait

func is_active(_item, _character) -> bool:
	return true

func on_tick(_item, _character, _delta: float):
	pass
	
func on_trigger(_item, _character):
	pass
	
func on_ability(_item, _character):
	pass

func on_damage(_item, _character, _damage):
	pass

func on_attack(_item, _character, _target, _damage):
	pass
