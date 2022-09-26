extends BuffAttribute
class_name BAMovementModifierPerStack

export (float) var ACCELERATION_MODIFIER = 0.8
export (float) var MAX_SPEED_MODIFIER = 0.5

var been_applied = false
var slowed_accel_amount = 0
var slowed_max_speed_amount = 0

func calculate_amount(modifier, current_amount):
	var total = modifier * current_amount
	if total > current_amount:
		return current_amount
	return modifier

func remove_buff(health):
	if been_applied:
		health.owner.ACCELERATION += slowed_accel_amount
		health.owner.MAX_SPEED += slowed_max_speed_amount
		been_applied = false
		
func apply_buff(buff, health):
	slowed_accel_amount = calculate_amount(ACCELERATION_MODIFIER * buff.stack, health.owner.ACCELERATION)
	health.owner.ACCELERATION -= slowed_accel_amount
	
	print(health.owner.MAX_SPEED * buff.stack * MAX_SPEED_MODIFIER)
	slowed_max_speed_amount = calculate_amount(MAX_SPEED_MODIFIER * buff.stack, health.owner.MAX_SPEED)
	health.owner.MAX_SPEED -= slowed_max_speed_amount
	
	been_applied = true

func on_apply(buff, health):
	remove_buff(health)
	apply_buff(buff, health)
	
func on_remove(buff, health):
	remove_buff(health)

func on_stack_changed(buff, health):
	remove_buff(health)
	apply_buff(buff, health)
