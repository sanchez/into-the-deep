tool
extends VBoxContainer


onready var GraphEditNode := $GraphEdit


func _on_AddWaypoint_pressed():
	GraphEditNode.add_waypoint()
