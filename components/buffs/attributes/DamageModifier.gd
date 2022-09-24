extends BuffAttribute
class_name BADamageModifier

export (float) var MODIFIER = 0.2

func on_damage(buff, health, damage):
	var extra_damage = damage.amount * buff.stack * MODIFIER
	health.health -= extra_damage
