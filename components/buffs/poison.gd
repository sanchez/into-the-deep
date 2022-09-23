extends Buff
class_name BuffPoison

var lifetime: float = 10.0

func _init():
	key = "Poison"
	icon = load("res://components/buffs/poison.png")
	stack = 0

func on_apply(health):
	lifetime = 1
	set_stack(stack + 1)
	
func on_damage(health: HealthStatus, damage: Damage):
	var extra_damage = damage.amount * stack * 0.2
	health.health -= extra_damage

func on_tick(health, delta: float):
	lifetime -= delta
	
	if lifetime <= 0:
		set_stack(stack - 1)
		lifetime = 1
