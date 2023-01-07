extends BuffAttribute
class_name BA_AssignBuff

@export var STACK_AMOUNT := 1

func invoke(buff: Buff, health: Health, _damage: Damage, _source):
	health.add_buff(buff, STACK_AMOUNT)
