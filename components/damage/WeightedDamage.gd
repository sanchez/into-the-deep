extends DamageDefinition
class_name DamageWeighted

export (Resource) var DAMAGE_A
export (Resource) var DAMAGE_B

export (float) var WEIGHT

func get_damage():
	var init_damage = Damage.new(BASE_ATTACK, BUFFS)
	
	var weight = randf()
	if weight <= WEIGHT:
		return init_damage.add(DAMAGE_A.get_damage())
	return init_damage.add(DAMAGE_B.get_damage())
