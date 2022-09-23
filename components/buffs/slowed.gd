extends Buff
class_name BuffSlowed

var lifetime: float = 1.0

func _init():
	key = "Slowed"
	icon = load("res://components/buffs/slowed.png")

func on_apply(_health):
	lifetime = 1
	set_stack(stack + 1)
	stack += 1

func on_tick(_health, delta: float):
	lifetime = lifetime - delta
	
	if lifetime <= 0:
		set_stack(stack - 1)
		lifetime = 1
		#health.remove_buff(self)
