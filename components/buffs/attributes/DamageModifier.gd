extends BuffAttribute
class_name BADamageModifier

export (float) var MODIFIER = 0.2

func on_damage(buff, _health, damage):
	var extra_damage = damage.amount * buff.stack * MODIFIER
	damage.amount += extra_damage
