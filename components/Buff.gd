class_name Buff

var key = "Base"
var stack: int = 1 setget set_stack

var attached_healths = []

var icon: Texture = load("res://components/buffs/default.png")

func attach(health):
	attached_healths.append(health)
	
func set_stack(value):
	stack = value
	for x in attached_healths:
		if stack <= 0:
			x.remove_buff(self)
		else:
			x.update()

func on_apply(_health):
	pass
	
func on_damage(_health):
	pass
	
func on_tick(_health, _delta: float):
	pass
