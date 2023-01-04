extends Area2D
class_name DoorWay


@export var TARGET: String = ""
@export var CHANNEL: String = ""
@export var IS_ACTIVE: bool = true


func _ready():
	body_entered.connect(_on_player_enter)


func get_world_manager() -> WorldManager:
	var p = get_parent()
	while not p is WorldManager:
		p = p.get_parent()
	return p

func _on_player_enter(_caller):
	if IS_ACTIVE:
		get_world_manager().set_world(TARGET, CHANNEL)
