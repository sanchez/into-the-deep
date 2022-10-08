extends ItemTrait
class_name ITPlayAttack

export (PackedScene) var ATTACK
export (Resource) var DAMAGE

func on_trigger(_item, character):
	var instance = ATTACK.instance() as Node2D
	#instance.connect("on_hit")
	character.add_child(instance)
