extends Node

signal on_attack(target)

export (int) var COOLDOWN = 1000
export (Resource) var DAMAGE_DEFINITION

onready var Timer := $Timer

func _ready():
	Timer.wait_time = COOLDOWN / 1000.0
	Timer.one_shot = true
	
func can_attack():
	return Timer.time_left == 0

func attack(target: Node2D):
	if can_attack():
		var damage = DAMAGE_DEFINITION.get_damage()
		
		# do the attack here
		for x in target.get_children():
			if x is HealthStatus:
				x.on_hit(damage)
		
		Timer.start()
		emit_signal("on_attack", target)
