tool
extends VBoxContainer

const LevelCollection := preload("res://addons/level_manager/definitions/LevelCollection.gd")

onready var GraphEditNode := $GraphEdit


func _on_AddWaypoint_pressed():
	GraphEditNode.add_waypoint()

func save():
	GraphEditNode.save_resource()

func edit(object: LevelCollection):
	GraphEditNode.load_resource(object)
