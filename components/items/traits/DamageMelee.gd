extends ITBaseDamageTrait
class_name ITDamageMelee

func on_trigger(item, character):
	var targets = get_targets(character, "Melee")
	if targets.size() > 0:
		var damage: Damage = DAMAGE.get_damage()
		item.on_attack(character, targets, damage)
		
		for x in targets:
			var healthStatus: HealthStatus = x.get_node("HealthStatus")
			healthStatus.on_hit(damage)
