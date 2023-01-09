extends WeaponInvItem
class_name SwordInvItem

@export var COOLDOWN := 0.5

var sword_swing := preload("res://addons/rpg_toolkit/animations/sword_swing/SwordSwing.tscn")

func attack(source, parameters: Dictionary):
	var animation = sword_swing.instantiate()
	animation.DAMAGE = DAMAGE
	animation.ICON = ICON
	
	if parameters.has("rotation"):
		animation.rotation = parameters["rotation"]
		
	if parameters.has("position"):
		animation.position = parameters["position"]
		
	source.add_child(animation)
