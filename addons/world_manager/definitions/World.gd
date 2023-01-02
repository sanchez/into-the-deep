extends Node2D
class_name World


func _ready():
	bind_doors(self)
	
	
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


func get_doors():
	pass


func bind_doors(x: Node):
	for item in x.get_children():
		if item is DoorWay:
			pass
