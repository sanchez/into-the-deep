extends ItemTrait
class_name ITPlayAttack

export (PackedScene) var ATTACK
export (Resource) var DAMAGE

func on_trigger(item, character):
	var instance = ATTACK.instance()
	instance.ICON = item.ICON
	instance.connect("on_hit", self, "_handle_on_hit", [character, item])
	#instance.connect("on_hit")
	character.add_child(instance)

func _handle_on_hit(target, character, item):
	var damage: Damage = DAMAGE.get_damage()
	item.on_attack(character, target, damage)
	
	var healthStatus: HealthStatus = target.get_node("HealthStatus")
	healthStatus.on_hit(damage)
