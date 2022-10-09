extends Node2D
class_name HealthStatus

export (int) var MAX_HEALTH = 100
export (Array, Resource) var STARTING_BUFFS

signal on_death()

var health: float = 0 setget set_health
var applied_buffs = {}
var position_offset = Vector2.ZERO

onready var BuffStart := $BuffStart
onready var Buffs := $Buffs
onready var HealthBar := $HealthBar
onready var RemainingHealth := $HealthBar/RemainingHealth

const HitNumber = preload("res://components/HitNumber.tscn")

func get_hit_position():
	return owner.global_position
	
func add_hit_number(_damage: Damage, actual_damage: float):
	var hitNumber = HitNumber.instance()
	hitNumber.DAMAGE_AMOUNT = actual_damage
	add_child(hitNumber)
	hitNumber.global_position = get_hit_position()

func _ready():
	health = MAX_HEALTH
	position_offset = position
	
	for x in STARTING_BUFFS:
		if x is Buff:
			if applied_buffs.has(x.KEY):
				applied_buffs[x.KEY].on_apply(self)
			else:
				x.on_apply(self)
				add_buff(x)
	
func set_health(value):
	var diff = health - value
	health = value
	add_hit_number(null, diff)
	if health <= 0:
		emit_signal("on_death")
		for key in applied_buffs:
			applied_buffs[key].on_remove(self)
	
func get_buff(key: String):
	if applied_buffs.has(key):
		return applied_buffs[key]
	return null
	
func add_buff(buff: Buff):
	applied_buffs[buff.KEY] = buff
	buff.attach(self)
	update()
	
func remove_buff(buff: Buff):
	buff.on_remove(self)
	applied_buffs.erase(buff.KEY)
	update()
	
func on_hit(damage: Damage):
	for key in applied_buffs:
		var buff = applied_buffs[key]
		if buff is Buff:
			buff.on_damage(self, damage)
			
	# a single hit of damage can't kill you
	var damage_amount = clamp(damage.amount, 0, MAX_HEALTH - 1)
	#add_hit_number(damage, damage_amount)
	set_health(health - damage_amount)
	
	for x in damage.buffs:
		if x is Buff:
			if applied_buffs.has(x.KEY):
				applied_buffs[x.KEY].on_apply(self)
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
	var font = Utils.font(4)
	
	var buff_offset = 0
	for key in applied_buffs:
		if applied_buffs[key] == null:
			continue
		
		var position = BuffStart.position
		position.x += buff_offset
		
		var buff = applied_buffs[key]
		draw_texture(buff.ICON, position)
		if buff.stack > 1:
			draw_string(font, position + Vector2(5, 10), str(buff.stack))
		
		buff_offset += 10
			
func draw_health():
	rotation = -owner.rotation
	global_position = owner.global_position + position_offset

	var health_ratio = clamp(health / MAX_HEALTH, 0, 1)
	RemainingHealth.rect_scale.x = health_ratio
