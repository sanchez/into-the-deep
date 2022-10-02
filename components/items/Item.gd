extends Resource
class_name Item

export (String) var KEY = ""
export (Texture) var ICON = null
export (Array, Resource) var TRAITS = []

export (int) var MAX_STACK = 1

export (float) var ICON_SCALE = 0.5

var stack_count = 1

func is_active(character) -> bool:
	for x in TRAITS:
		if not x.is_active(self, character):
			return false
	return true

func on_tick(character, delta: float):
	for x in TRAITS:
		x.on_tick(self, character, delta)
	
func on_trigger(character):
	for x in TRAITS:
		x.on_trigger(self, character)
	
func on_ability(character):
	for x in TRAITS:
		x.on_ability(self, character)

func on_damage(character, damage):
	for x in TRAITS:
		x.on_damage(self, character, damage)

func on_attack(character, target, damage):
	for x in TRAITS:
		x.on_attack(self, character, target, damage)
