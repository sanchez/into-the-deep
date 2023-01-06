extends BuffAttribute
class_name BA_ChanceToApply

@export var CHANCE := 0.5
@export var CHILD: BuffAttribute

func invoke(buff: Buff, health: Health, damage: Damage, source):
	var f = randf()
	if f >= CHANCE:
		CHILD.invoke(buff, health, damage, source)
