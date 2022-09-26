extends BuffAttribute
class_name BALifetime

export (float) var INITIAL_LIFETIME = 1.0

var lifetime: float

func on_apply(_buff, _health):
	lifetime = INITIAL_LIFETIME
	
func on_tick(buff, _health, delta: float):
	lifetime -= delta
	
	while lifetime <= 0:
		buff.stack -= 1
		lifetime += INITIAL_LIFETIME
