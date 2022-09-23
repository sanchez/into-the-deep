extends Buff
class_name BuffSlowed

var lifetime: float = 1.0
var slowed_accel_amount = 0
var slowed_max_speed_amount = 0

func _init():
	key = "Slowed"
	icon = load("res://components/buffs/slowed.png")
	stack = 0

func on_apply(health):
	lifetime = 1
	set_stack(stack + 1)
	if stack == 1:
		# we just got applied so we need to do our thing
		slowed_accel_amount = health.owner.ACCELERATION * 0.8
		health.owner.ACCELERATION -= slowed_accel_amount
		slowed_max_speed_amount = health.owner.MAX_SPEED * 0.5
		health.owner.MAX_SPEED -= slowed_max_speed_amount

func on_tick(health, delta: float):
	lifetime = lifetime - delta
	
	if lifetime <= 0:
		set_stack(stack - 1)
		lifetime = 1
		
		if stack == 0:
			# we just got removed so we need to undo our thing
			health.owner.ACCELERATION += slowed_accel_amount
			health.owner.MAX_SPEED += slowed_max_speed_amount
