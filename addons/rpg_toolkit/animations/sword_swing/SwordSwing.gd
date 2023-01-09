extends Node2D

@export var DAMAGE: Damage
@export var ICON: Texture2D

func _ready():
	var sprite_node := $Node2D/Sprite2D
	sprite_node.texture = ICON


func on_hit(body: Node):
	if body.has_node("Health"):
		var health = body.get_node("Health")
		if health is Health:
			health.take_damage(DAMAGE, self)
