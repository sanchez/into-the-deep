class_name Damage

var amount: float = 0
var buffs: Array = []

func _init(init_amount: float, init_buffs = []):
	amount = init_amount
	buffs = init_buffs
