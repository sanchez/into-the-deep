extends Resource
class_name Buff

export (String) var KEY
export (Texture) var ICON = preload("res://components/buffs/default.png")
export (bool) var IS_DEBUFF = true
export (Array, Resource) var ATTRIBUTES

var stack: int = 1 setget set_stack

var attached_healths = []

func attach(health):
	attached_healths.append(health)
	
func set_stack(value):
	stack = value
	
	for x in ATTRIBUTES:
		for health in attached_healths:
			x.on_stack_changed(self, health)
	
	for x in attached_healths:
		if not is_instance_valid(x):
			continue
		if stack <= 0:
			x.remove_buff(self)
		else:
			x.update()

func on_apply(health):
	for x in ATTRIBUTES:
		x.on_apply(self, health)
		
func on_remove(health):
	for x in ATTRIBUTES:
		x.on_remove(self, health)
	
func on_damage(health, damage):
	for x in ATTRIBUTES:
		x.on_damage(self, health, damage)
		
func on_attack(health):
	for x in ATTRIBUTES:
		if not x.on_attack(self, health):
			return false
	return true
	
func on_ability():
	for x in ATTRIBUTES:
		if not x.on_ability(self):
			return false
	return true
	
func on_tick(health, delta: float):
	for x in ATTRIBUTES:
		x.on_tick(self, health, delta)
