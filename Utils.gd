extends Node

var PIXEL_SIZE = 2
var TILE_SIZE = 64

var fontData = load("res://FFFFORWA.TTF")
var font = DynamicFont.new()

func font(size: int):
	var font = DynamicFont.new()
	font.font_data = fontData
	font.size = size
	return font

func find_closest_node(point: Vector2, nodes: Array) -> Node2D:
	var best_match = null
	var best_dist = -1
	
	for x in nodes:
		if x is Node2D:
			var dist = (x.global_position - point).length_squared()
			if best_dist == -1 or dist < best_dist:
				best_match = x
				
	return best_match
