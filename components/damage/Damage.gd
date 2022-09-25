class_name Damage

var amount: float
var buffs: Array

func _init(init_amount: float, init_buffs = []):
	amount = init_amount
	buffs = init_buffs
	
func add(d: Damage):
	amount += d.amount
	buffs.append_array(d.buffs)
	return self
