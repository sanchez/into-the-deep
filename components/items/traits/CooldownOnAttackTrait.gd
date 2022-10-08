extends ItemTrait
class_name ITCooldownOnAttack

export (float) var COOLDOWN = 1.0

var cooldown_amount = 0.0

func is_active(_item, _character) -> bool:
	return cooldown_amount >= COOLDOWN

func on_tick(_item, _character, delta: float):
	if cooldown_amount < COOLDOWN:
		cooldown_amount += delta

func on_trigger(_item, _character):
	cooldown_amount = 0.0
