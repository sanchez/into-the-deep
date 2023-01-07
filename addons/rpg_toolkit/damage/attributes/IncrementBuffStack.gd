extends BuffAttribute
class_name BA_IncrementBuffStack

@export var AMOUNT := 1

func invoke(buff: Buff, health: Health, _damage: Damage, _source):
	health.set_buff_relative(buff, AMOUNT)
