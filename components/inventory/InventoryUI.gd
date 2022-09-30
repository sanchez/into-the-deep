extends Node2D

export (NodePath) var INVENTORY_PATH

onready var WeaponIcon := $CanvasLayer/Background/CenterContainer/WeaponIcon
onready var AbilityIcon := $CanvasLayer/TextureRect/CenterContainer/AbilityIcon

onready var Artifact1 := $CanvasLayer/Artifacts/MarginContainer/HBoxContainer/CenterContainer/Artifact1
onready var Artifact2 := $CanvasLayer/Artifacts/MarginContainer/HBoxContainer/CenterContainer2/Artifact2
onready var Artifact3 := $CanvasLayer/Artifacts/MarginContainer/HBoxContainer/CenterContainer3/Artifact3
onready var Artifact4 := $CanvasLayer/Artifacts/MarginContainer/HBoxContainer/CenterContainer4/Artifact4

var show_inventory = false

func get_inventory():
	var node = get_node(INVENTORY_PATH)
	for x in node.get_children():
		if x is Inventory:
			return x
	return null

func render_inventory_toolbar(inventory: Inventory):
	var weapon = inventory.get_weapon()
	if weapon == null:
		WeaponIcon.hide()
		WeaponIcon.texture = null
	else:
		WeaponIcon.show()
		WeaponIcon.texture = weapon.ICON
		
	var artifactIcons = [Artifact1, Artifact2, Artifact3, Artifact4]
	for x in artifactIcons:
		x.hide()
	var artifacts = inventory.get_artifacts()
	for x in range(0, min(4, artifacts.size())):
		var artifact = artifacts[x]
		artifactIcons[x].texture = artifact.ICON
		artifactIcons[x].show()
		
	AbilityIcon.hide()
	
func render_inventory_picker(inventory: Inventory):
	pass

func _process(delta):
	global_position = Vector2.ZERO
	global_rotation = 0
	global_scale = Vector2.ONE
	
	if Input.is_action_just_pressed("inventory"):
		show_inventory = not show_inventory
		
	var inventory = get_inventory()
	if inventory == null:
		return
	
	if show_inventory:
		render_inventory_picker(inventory)
	render_inventory_toolbar(inventory)
