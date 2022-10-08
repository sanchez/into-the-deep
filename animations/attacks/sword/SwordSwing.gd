extends Area2D

export (Texture) var ICON

signal on_hit(item)

onready var Sprite := $Sprite

func _ready():
	Sprite.texture = ICON

func _on_SwordSwing_body_entered(body):
	emit_signal("on_hit", body)
