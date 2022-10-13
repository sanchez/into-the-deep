extends Node

var PIXEL_SIZE = 2
var TILE_SIZE = 64

var fontData = load("res://ui/FFFFORWA.TTF")

var preloaded_fonts = {
	2: create_font(2),
	3: create_font(3),
	4: create_font(4),
	5: create_font(5)
}

func create_font(size: int):
	var f = DynamicFont.new()
	f.font_data = fontData
	f.size = size
	return f
	
func font(size: int):
	return preloaded_fonts[size]

func find_closest_node(point: Vector2, nodes: Array) -> Node2D:
	var best_match = null
	var best_dist = -1
	
	for x in nodes:
		if x is Node2D:
			var dist = (x.global_position - point).length_squared()
			if best_dist == -1 or dist < best_dist:
				best_match = x
				
	return best_match

func smooth_to(current_value: float, target_value: float, max_step_size: float):
	if current_value == target_value:
		return current_value
		
	if current_value < target_value:
		var next_step = current_value + max_step_size
		if next_step > target_value:
			return target_value
		return next_step
		
	if current_value > target_value:
		var next_step = current_value - max_step_size
		if next_step < target_value:
			return target_value
		return next_step
		
	return target_value

func find_world(node: Node) -> BaseWorld:
	if not is_instance_valid(node):
		return null
		
	if node is BaseWorld:
		return node as BaseWorld
	return find_world(node.owner)
