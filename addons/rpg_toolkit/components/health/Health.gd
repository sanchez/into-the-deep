extends Node
class_name Health


@export var HEALTH: float = 100
@export var MAX_HEALTH: float = 100
@export var STATUS: Array[BuffStackPair] = []

signal on_death()


func add_buff(buff: Buff, stack: int, source = null):
	var pair = BuffStackPair.new()
	pair.BUFF = buff
	pair.stack = stack
	STATUS.append(pair)
	
	var damage = Damage.new()
	if not is_instance_valid(source):
		source = self
	buff.on_apply(self, damage, source)
	take_damage(damage, source)
	


func set_buff(buff: Buff, stack: int):
	if stack == 0:
		remove_buff(buff)
		
	for x in STATUS:
		if x.BUFF.KEY == buff.KEY:
			x.STACK = stack
			return
			
	add_buff(buff, stack)
			
			
func set_buff_relative(buff: Buff, stack: int):
	if stack == 0:
		return
		
	for x in STATUS:
		if x.BUFF.KEY == buff.KEY:
			x.STACK += stack
			return
			
	if stack > 0:
		add_buff(buff, stack)


func remove_buff(buff: Buff):
	for x in range(STATUS.size()):
		if STATUS[x].BUFF.KEY == buff.KEY:
			STATUS.remove_at(x)
			
			
func _set_health(health: int, relative: int):
	HEALTH = clamp(health, 0, MAX_HEALTH)
	if HEALTH <= 0:
		emit_signal("on_death")


func _set_health_absolute(health: int):
	_set_health(health, health - HEALTH)
	
func _set_health_relative(health: int):
	_set_health(HEALTH + health, health)
	
	
func take_damage(damage: Damage, source):
	for buff in damage.BUFFS:
		buff.on_attack(self, damage, source)
	
	for buff_pair in STATUS:
		buff_pair.BUFF.on_receive_damage(self, damage, source)
		
	_set_health_relative(damage.AMOUNT)


func _process(delta):
	for buff in STATUS:
		var damage = Damage.new()
		buff.BUFF.on_tick(self, damage, self, delta)
		take_damage(damage, self)
