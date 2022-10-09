extends Node2D

export (NodePath) var INVENTORY_PATH

onready var CoinsLabel := $CanvasLayer/VBoxContainer/HBoxContainer/Coins
onready var CrystalsLabel := $CanvasLayer/VBoxContainer/HBoxContainer2/Crystal

func get_inventory() -> Inventory:
	var node = get_node(INVENTORY_PATH)
	for x in node.get_children():
		if x is Inventory:
			return x
	return null

func render_inventory_toolbar(inventory: Inventory):
	#var weapon = inventory.get_weapon()
	#if weapon == null:
	#	WeaponIcon.hide()
	#	WeaponIcon.texture = null
	#else:
	#	WeaponIcon.show()
	#	WeaponIcon.texture = weapon.ICON
		
	#var artifactIcons = [Artifact1, Artifact2, Artifact3, Artifact4]
	#for x in artifactIcons:
	#	x.hide()
	#var artifacts = inventory.get_artifacts()
	#for x in range(0, min(4, artifacts.size())):
	#	var artifact = artifacts[x]
	#	artifactIcons[x].texture = artifact.ICON
	#	artifactIcons[x].show()
		
	CoinsLabel.text = str(inventory.get_coins())
	CrystalsLabel.text = str(inventory.get_crystals())
	
func _process(_delta):
	global_position = Vector2.ZERO
	global_rotation = 0
	global_scale = Vector2.ONE
	
	var inventory = get_inventory()
	if not is_instance_valid(inventory):
		return
	
	render_inventory_toolbar(inventory)
