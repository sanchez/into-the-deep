extends BuffAttribute
class_name BAChanceToApply

export (float) var CHANCE = 0.5
export (Resource) var TRUE_ATTRIBUTE

func roll(_buff):
	var r = randf()
	return r <= CHANCE

func on_apply(buff, health):
	if roll(buff):
		TRUE_ATTRIBUTE.on_apply(buff, health)
	
func on_damage(buff, health, damage):
	if roll(buff):
		TRUE_ATTRIBUTE.on_damage(buff, health, damage)
	
func on_tick(buff, health, delta: float):
	if roll(buff):
		TRUE_ATTRIBUTE.on_tick(buff, health, delta)
