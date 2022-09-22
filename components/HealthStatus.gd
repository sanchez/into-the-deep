extends Node
class_name HealthStatus

export (int) var MAX_HEALTH = 100

var health: float = 0
var applied_buffs = {}

func _ready():
	health = MAX_HEALTH
	
func on_hit(damage: Damage):
	var damage_amount = clamp(damage.amount, 0, MAX_HEALTH)
	health -= damage_amount
	
	for key in applied_buffs:
		var buff = applied_buffs[key]
		if buff is Buff:
			buff.on_damage(self)
	
	for x in damage.buffs:
		if x is Buff:
			x.on_apply(self)

func _process(delta):
	for key in applied_buffs:
		var buff = applied_buffs[key]
		if buff is Buff:
			buff.on_tick(self, delta)
