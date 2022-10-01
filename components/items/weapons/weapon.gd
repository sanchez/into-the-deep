extends Item
class_name Weapon

export (int) var DAMAGE = 0
export (Array, Resource) var BUFFS = []
export (float) var COOLDOWN = 1.0

var cooldown_amount = 0.0
