tool
extends GraphEdit

const LevelNode := preload("res://addons/level_manager/ui/controls/LevelNode.tscn")
const WaypointNode := preload("res://addons/level_manager/ui/controls/Waypoint.tscn")

func can_drop_data(position, data):
	var file_paths = data["files"]
	for x in file_paths:
		if not x.ends_with(".tscn"):
			return false
	return true
	
	
func add_file(path, position):
	var level_node = LevelNode.instance()
	level_node.FILE_PATH = path
	level_node.offset = position
	level_node.connect("on_delete", self, "_handle_delete_node", [level_node]);
	add_child(level_node)


func drop_data(position, data):
	var file_paths = data["files"]
	for path in file_paths:
		call_deferred("add_file", path, position)

func add_waypoint():
	var instance = WaypointNode.instance()
	instance.connect("on_delete", self, "_handle_delete_node", [instance])
	add_child(instance)

func disconnect_whole_node(node):
	var node_name = node.name
	for x in get_connection_list():
		if x.from == node_name or x.to == node_name:
			disconnect_node(x.from, x.from_port, x.to, x.to_port)


func _handle_delete_node(node):
	disconnect_whole_node(node)
	node.queue_free()


func _on_GraphEdit_connection_request(from, from_slot, to, to_slot):
	connect_node(from, from_slot, to, to_slot)


func serialize():
	""
