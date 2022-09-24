extends BuffAttribute

export (float) var INITIAL_LIFETIME = 1.0

var lifetime: float

func on_apply(buff, health):
	lifetime = INITIAL_LIFETIME
	
func on_tick(buff, health, delta: float):
	lifetime -= delta
	
	if lifetime <= 0:
		buff.stack -= 1
		lifetime = INITIAL_LIFETIME
