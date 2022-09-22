extends Node

func find_closest_node(point: Vector2, nodes: Array) -> Node2D:
	var best_match = null
	var best_dist = -1
	
	for x in nodes:
		if x is Node2D:
			var dist = (x.global_position - point).length_squared()
			if best_dist == -1 or dist < best_dist:
				best_match = x
				
	return best_match
