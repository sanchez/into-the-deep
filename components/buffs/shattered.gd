extends Buff
class_name BuffShattered

var lifetime: float = 3.0

func _init():
	key = "Shattered"
	icon = load("res://components/buffs/shattered.png")

func on_apply(_health):
	lifetime = 1
	
func on_damage(_health: HealthStatus, damage: Damage):
	damage.amount *= 1.5

func on_tick(_health, delta: float):
	lifetime -= delta
	
	if lifetime <= 0:
		set_stack(stack - 1)
		lifetime = 1
