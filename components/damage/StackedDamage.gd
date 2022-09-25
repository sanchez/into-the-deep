extends DamageDefinition
class_name DamageStacked

export (Array, Resource) var DAMAGES

func get_damage():
	var init_damage = Damage.new(BASE_ATTACK, BUFFS)
	
	for x in DAMAGES:
		init_damage.add(x)
		
	return init_damage
