extends StaticBody2D

export (Resource) var DROP_POOL

var is_broken = false
const chest_broken_texture = preload("res://components/items/drops/chest/chest-broken.png")
const DroppedItem = preload("res://components/items/DroppedItem.tscn")

onready var SpriteNode := $Sprite

func drop_item():
	if is_broken:
		return
	
	is_broken = true
	SpriteNode.texture = chest_broken_texture
	
	var item = DROP_POOL.get_drop()
	var drop_location = Vector2(rand_range(-1, 1), rand_range(-1, 1)) * 20
	var dropped_item = DroppedItem.instance()
	dropped_item.ITEM = item
	dropped_item.position = drop_location
	call_deferred("add_child", dropped_item)

func _on_Area2D_area_entered(area):
	drop_item()

func _on_Area2D_body_entered(body):
	drop_item()
