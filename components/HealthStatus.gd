extends Node2D
class_name HealthStatus

export (int) var MAX_HEALTH = 100

var health: float = 0
var applied_buffs = {}
var position_offset = Vector2.ZERO

onready var BuffStart := $BuffStart
onready var Buffs := $Buffs
onready var HealthBar := $HealthBar
onready var RemainingHealth := $HealthBar/RemainingHealth

func _ready():
	health = MAX_HEALTH
	position_offset = position
	
func get_buff(key: String):
	if applied_buffs.has(key):
		return applied_buffs[key]
	return null
	
func add_buff(buff: Buff):
	applied_buffs[buff.key] = buff
	buff.attach(self)
	update()
	
func remove_buff(buff: Buff):
	applied_buffs.erase(buff.key)
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
			if applied_buffs.has(x.key):
				applied_buffs[x.key].on_apply(self)
			else:
				x.on_apply(self)
				add_buff(x)

func _process(delta):
	for key in applied_buffs:
		var buff = applied_buffs[key]
		if buff is Buff:
			buff.on_tick(self, delta)
			
	draw_health()
	
func _draw():
	var font = Utils.font(2)
	
	var buff_offset = 0
	for key in applied_buffs:
		if applied_buffs[key] == null:
			continue
		
		var position = BuffStart.position
		position.x += buff_offset
		
		var buff = applied_buffs[key]
		draw_texture(buff.icon, position)
		if buff.stack != -1:
			draw_string(font, position + Vector2(5, 10), str(buff.stack))
		
		buff_offset += 10
			
func draw_health():
	rotation = -owner.rotation
	global_position = owner.global_position + position_offset

	var health_ratio = clamp(health / MAX_HEALTH, 0, 1)
	RemainingHealth.rect_scale.x = health_ratio
