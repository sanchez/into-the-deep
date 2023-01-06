extends Resource
class_name Buff

@export var KEY := ""
@export var ICON: Texture2D

@export var ON_APPLY: Array[BuffAttribute] = []
@export var ON_REMOVE: Array[BuffAttribute] = []
@export var ON_RECEIVE_DAMAGE: Array[BuffAttribute] = []
@export var ON_ATTACK: Array[BuffAttribute] = []

@export var ON_TICK: Array[BuffAttributeOnTick] = []

func on_apply(health: Health, damage: Damage, source):
	for x in ON_APPLY:
		x.invoke(self, health, damage, source)
	
func on_remove(health: Health, damage: Damage, source):
	for x in ON_REMOVE:
		x.invoke(self, health, damage, source)
	
func on_receive_damage(health: Health, damage: Damage, source):
	for x in ON_RECEIVE_DAMAGE:
		x.invoke(self, health, damage, source)
	
func on_attack(health: Health, damage: Damage, source):
	for x in ON_ATTACK:
		x.invoke(self, health, damage, source)
	
func on_tick(health: Health, damage: Damage, source, tick: float):
	for x in ON_TICK:
		x.invoke(self, health, damage, source, tick)
