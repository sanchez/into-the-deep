extends Buff
class_name CompositeBuff

export (Array, Resource) var CHILDREN

func on_apply(health):
	for x in CHILDREN:
		x.on_apply(health)
	
func on_damage(health, damage):
	for x in CHILDREN:
		x.on_damage(health, damage)
	
func on_tick(health, delta: float):
	for x in CHILDREN:
		x.on_tick(health, delta)
