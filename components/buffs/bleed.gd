extends Buff
class_name BuffBleed

var lifetime: float = 1.0
var DAMAGE_AMOUNT: float = 5

func _init():
	key = "Bleed"
	icon = load("res://components/buffs/bleed.png")
	stack = 0

func on_apply(_health):
	lifetime = 1
	set_stack(stack + 1)

func on_tick(health, delta: float):
	lifetime -= delta
	
	health.health -= delta * DAMAGE_AMOUNT
	
	if lifetime <= 0:
		set_stack(stack - 1)
		lifetime = 1
