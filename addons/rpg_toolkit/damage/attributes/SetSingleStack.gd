extends BuffAttribute
class_name BA_SetSingleStack

@export var BUFF: Buff
@export var STACK_AMOUNT := 1

func invoke(buff: Buff, health: Health, _damage: Damage, _source):
	health.add_buff(BUFF, STACK_AMOUNT)
