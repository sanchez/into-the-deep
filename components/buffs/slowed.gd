extends Buff
class_name BuffSlowed

var lifetime: float = 1.0

func _init():
	key = "Slowed"
	icon = load("res://components/buffs/slowed.png")

func on_apply(health):
	lifetime = 1

func on_tick(health, delta: float):
	lifetime = lifetime - delta
	
	if lifetime <= 0:
		health.remove_buff(self)
