class_name Damage

var amount: float = 0
var buffs: Array = []

func _init(amount: float, buffs = []):
	self.amount = amount
	self.buffs = buffs
