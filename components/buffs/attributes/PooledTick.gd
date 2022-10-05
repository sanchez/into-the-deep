extends BuffAttribute
class_name BAPooledTick

export (Resource) var CHILD
export (float) var POOL_AMOUNT

var current_delta_count = 0

func on_apply(buff, health):
	CHILD.on_apply(buff, health)
	
func on_remove(buff, health):
	CHILD.on_remove(buff, health)
	
func on_damage(buff, health, damage):
	CHILD.on_damage(buff, health, damage)
	
func on_attack(buff, health):
	return CHILD.on_attack(buff, health)
	
func on_ability(buff):
	return CHILD.on_ability(buff)
	
func on_tick(buff, health, delta: float):
	current_delta_count += delta
	while current_delta_count >= POOL_AMOUNT:
		current_delta_count -= POOL_AMOUNT
		CHILD.on_tick(buff, health, POOL_AMOUNT)

func on_stack_changed(buff, health):
	CHILD.on_stack_changed(buff, health)
