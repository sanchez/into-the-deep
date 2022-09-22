extends Node

signal on_attack(target)

export (int) var COOLDOWN = 1000
export (int) var REFILL_COOLDOWN = 1000
export (int) var MAX_AMMO_COUNT = 5

onready var CooldownTimer := $CooldownTimer
onready var RefillTimer := $RefillTimer

var ammo_count = 0

func _ready():
	CooldownTimer.wait_time = COOLDOWN / 1000.0
	CooldownTimer.one_shot = true
	
	RefillTimer.wait_time = REFILL_COOLDOWN / 1000.0
	RefillTimer.one_shot = false
	
	ammo_count = MAX_AMMO_COUNT

func can_attack():
	return ammo_count > 0 and CooldownTimer.wait_time == 0

func attack(target: Node2D, damage: Damage):
	if can_attack():
		RefillTimer.stop()
		for x in target.get_children():
			if x is HealthStatus:
				x.on_hit(damage)

func _on_CooldownTimer_timeout():
	RefillTimer.restart()
	RefillTimer.start()

func _on_RefillTimer_timeout():
	if ammo_count < MAX_AMMO_COUNT:
		ammo_count += 1
