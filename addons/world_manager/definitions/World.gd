extends Node2D
class_name World


func _get_world_manager():
	var p = get_parent()
	while not p is WorldManager:
		p = p.get_parent()
	return p

	
func _find_spawn(node: Node, channel: String) -> Spawn:
	for x in node.get_children():
		if x is Spawn:
			return x
			
	for x in node.get_children():
		var res = _find_spawn(x, channel)
		if is_instance_valid(res):
			return res
			
	return null
	
	
func find_spawn(channel: String) -> Spawn:
	return _find_spawn(self, channel)
