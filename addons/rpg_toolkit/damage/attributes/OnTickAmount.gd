extends BuffAttributeOnTick
class_name BA_OnTickAmount

var time_passed = 0.0

@export var AMOUNT: float = 1.0
@export var CHILD: BuffAttribute


func invoke(buff: Buff, health: Health, damage: Damage, source, tick: float):
	time_passed += tick
	
	if time_passed >= AMOUNT:
		time_passed = 0
		CHILD.invoke(buff, health, damage, source)
