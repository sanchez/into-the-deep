tool
extends Area2D
class_name DroppedItem

export (Resource) var ITEM = null

onready var sprite := $Sprite

func get_icon() -> Texture:
	return ITEM.ICON

func _ready():
	sprite.texture = get_icon()
	sprite.scale.x = ITEM.ICON_SCALE
	sprite.scale.y = ITEM.ICON_SCALE
