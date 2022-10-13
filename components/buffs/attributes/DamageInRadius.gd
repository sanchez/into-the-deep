extends BuffAttribute
class_name BADamageInRadius

export (Resource) var DAMAGE
export (float) var RADIUS

export (bool) var ON_APPLY = false
export (bool) var ON_REMOVE = false
export (bool) var ON_DAMAGE = false
export (bool) var ON_ATTACK = false
export (bool) var ON_TICK = false

func get_damage():
	return DAMAGE.get_damage()
	
func damage_in_radius(health):
	var world = Utils.find_world(health)
	if not is_instance_valid(world):
		return
	var targets = world.get_damagable_within_radius(health.global_position, RADIUS)
	
	var damage = get_damage()
	
	for x in targets:
		var enemy_health = x.find_node("HealthStatus")
		enemy_health.on_hit(damage)

func on_apply(_buff, health):
	if ON_APPLY:
		damage_in_radius(health)
	
func on_remove(_buff, health):
	if ON_REMOVE:
		damage_in_radius(health)
	
func on_damage(_buff, health, _damage):
	if ON_DAMAGE:
		damage_in_radius(health)
	
func on_attack(_buff, health):
	if ON_ATTACK:
		damage_in_radius(health)
	return true
	
func on_ability(_buff):
	return true
	
func on_tick(_buff, health, _delta: float):
	if ON_TICK:
		damage_in_radius(health)
