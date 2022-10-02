extends ItemTrait
class_name ITBaseDamageTrait

export (Resource) var DAMAGE

func get_targets(character, node_name: String) -> Array:
	if character.has_node("Melee"):
		var melee: RayCast2D = character.get_node("Melee")
		if melee.is_colliding():
			var target = melee.get_collider()
			if target.has_node("HealthStatus"):
				return [target]
	return []

func on_trigger(item, character):
	var targets = get_targets(character, "Melee")
	if targets.size() > 0:
		var damage: Damage = DAMAGE.get_damage()
		item.on_attack(character, targets, damage)
		
		for x in targets:
			var healthStatus: HealthStatus = x.get_node("HealthStatus")
			healthStatus.on_hit(damage)
