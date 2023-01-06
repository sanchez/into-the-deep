extends BuffAttribute
class_name BA_TakeDamage

@export var PREVENT_LOOP = true
@export var DAMAGE: Damage

func invoke(_buff: Buff, health: Health, _damage: Damage, source):
	if PREVENT_LOOP and source is BA_TakeDamage:
		return
		
	await health.get_tree().create_timer(0.1).timeout
	health.take_damage(DAMAGE, self)
