tool
extends GraphEdit


const LevelNode := preload("res://addons/level_manager/ui/controls/LevelNode.tscn")
const WaypointNode := preload("res://addons/level_manager/ui/controls/Waypoint.tscn")
const LevelCollection := preload("res://addons/level_manager/definitions/LevelCollection.gd")


var current_resource: LevelCollection = null


func can_drop_data(position, data):
	var file_paths = data["files"]
	for x in file_paths:
		if not x.ends_with(".tscn"):
			return false
	return true
	
	
func add_file(path, position):
	var level_node = LevelNode.instance()
	level_node.offset = position
	level_node.connect("on_delete", self, "_handle_delete_node", [level_node])
	level_node.DEFINITION.FILE_PATH = path
	add_child(level_node)
	
	if is_instance_valid(current_resource):
		current_resource.NODES.append(level_node.DEFINITION)


func drop_data(position, data):
	var file_paths = data["files"]
	for path in file_paths:
		call_deferred("add_file", path, position)

func add_waypoint():
	var instance = WaypointNode.instance()
	instance.connect("on_delete", self, "_handle_delete_node", [instance])
	add_child(instance)
	
	if is_instance_valid(current_resource):
		current_resource.WAYPOINTS.append(instance.DEFINITION)

func disconnect_whole_node(node):
	var node_name = node.name
	for x in get_connection_list():
		if x.from == node_name or x.to == node_name:
			disconnect_node(x.from, x.from_port, x.to, x.to_port)
			
	var definition_id = node.DEFINITION.ID
	if is_instance_valid(current_resource):
		for x in current_resource.CONNECTIONS:
			if x.FROM_ID == definition_id or x.TO_ID == definition_id:
				current_resource.CONNECTIONS.erase(x)


func _handle_delete_node(node):
	disconnect_whole_node(node)
	if is_instance_valid(current_resource):
		current_resource.NODES.erase(node.DEFINITION)
		current_resource.WAYPOINTS.erase(node.DEFINITION)
	
	node.queue_free()


func _on_GraphEdit_connection_request(from, from_slot, to, to_slot):
	connect_node(from, from_slot, to, to_slot)


func load_resource(resource: LevelCollection):
	save_resource()
	current_resource = resource

	for x in resource.WAYPOINTS:
		var instance = WaypointNode.instance()
		instance.DEFINITION = x
		instance.offset = x.POSITION
		instance.connect("on_delete", self, "_handle_delete_node", [instance])
		add_child(instance)
		
	for x in resource.NODES:
		var instance = WaypointNode.instance()
		instance.DEFINITION = x
		instance.offset = x.POSITION
		instance.connect("on_delete", self, "_handle_delete_node", [instance])
		add_child(instance)


func save_resource():
	if is_instance_valid(current_resource):
		ResourceSaver.save(current_resource.resource_path, current_resource)
