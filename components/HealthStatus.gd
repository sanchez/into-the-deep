extends Node2D
class_name HealthStatus

export (int) var MAX_HEALTH = 100

var health: float = 0
var applied_buffs = {}
var position_offset = Vector2.ZERO

onready var BuffStart := $BuffStart
onready var Buffs := $Buffs

func _ready():
	health = MAX_HEALTH
	position_offset = position
	
func get_buff(key: String):
	if applied_buffs.has(key):
		return applied_buffs[key]
	return null
	
func add_buff(buff: Buff):
	applied_buffs[buff.key] = buff
	update()
	
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
			
	draw_health()
	
func _draw():
	var buff_offset = 0
	for key in applied_buffs:
		var position = BuffStart.position
		position.x += buff_offset
		
		draw_texture(applied_buffs[key].icon, position)
		
		buff_offset += 10
			
func draw_health():
	rotation = -owner.rotation
	global_position = owner.global_position + position_offset
