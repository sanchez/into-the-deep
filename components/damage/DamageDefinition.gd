extends Resource
class_name DamageDefinition

export (float) var BASE_ATTACK = 0.0
export (Array, Resource) var BUFFS

func get_damage():
	return Damage.new(BASE_ATTACK, BUFFS)
