extends BuffAttribute
class_name BAMovementModifier

export (float) var ACCELERATION_MODIFIER = 0.8
export (float) var MAX_SPEED_MODIFIER = 0.5

var been_applied = false
var slowed_accel_amount = 0
var slowed_max_speed_amount = 0

func on_apply(buff, health):
	if been_applied == false:
		been_applied = true
		
		# we just got applied so we need to slow the character down
		slowed_accel_amount = health.owner.ACCELERATION * ACCELERATION_MODIFIER
		health.owner.ACCELERATION -= slowed_accel_amount
		
		slowed_max_speed_amount = health.owner.MAX_SPEED * MAX_SPEED_MODIFIER
		health.owner.MAX_SPEED -= slowed_max_speed_amount
	
func on_remove(buff, health):
	if been_applied:
		# we just got removed so we need to undo our thing
		health.owner.ACCELERATION += slowed_accel_amount
		health.owner.MAX_SPEED += slowed_max_speed_amount
		
		# just in case
		slowed_accel_amount = 0
		slowed_max_speed_amount = 0
		
		been_applied = false
