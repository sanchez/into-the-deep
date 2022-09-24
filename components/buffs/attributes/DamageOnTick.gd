extends BuffAttribute
class_name BADamageOnTick

export (float) var DAMAGE_PER_SECOND = 5.0

func on_tick(buff, health, delta: float):
	health.health -= delta * DAMAGE_PER_SECOND
