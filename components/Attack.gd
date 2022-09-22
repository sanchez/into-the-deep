extends Node

signal on_attack(target)

export (int) var COOLDOWN = 250
export (int) var DAMAGE = 5

onready var Timer := $Timer

func _ready():
	Timer.wait_time = COOLDOWN
	Timer.one_shot = true

func attack(target: Node2D, damage: Damage):
	if Timer.is_stopped():
		# do the attack here
		for x in target.get_children():
			if x is HealthStatus:
				x.on_hit(damage)
		
		Timer.start()
		emit_signal("on_attack", target)
