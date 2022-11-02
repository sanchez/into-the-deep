extends Resource


export (Array, Resource) var WAYPOINTS
export (Array, Resource) var NODES
export (Array, Resource) var CONNECTIONS


func get_waypoint(name):
	for x in WAYPOINTS:
		if x.NAME == name:
			return x
			
	return null


func get_level_node(id):
	for x in NODES:
		if x.ID == id:
			return x
			
	for x in WAYPOINTS:
		if x.ID == id:
			return x
			
	return null
	
	
func load_level_from_id(id):
	pass


func get_next_connections(id, channel):
	var res = []
	
	for x in CONNECTIONS:
		if x.FROM_ID == id and x.FROM_CHANNEL == channel:
			res.append(x)
	
	return res
	

func get_next_level_waypoint(waypoint: LevelManagerWaypoint):
	var possible_connections = []
	for x in WAYPOINTS:
		if x.NAME == waypoint.NAME:
			var conns = get_next_connections(x.ID, "main")
			possible_connections.append_array(conns)
	
	var i = randi() % possible_connections.size()
	var next_connection = possible_connections[i]
	var next_node = get_level_node(next_connection.TO_ID)
	if next_node is LevelManagerWaypoint:
		return get_next_level_waypoint(next_node)
		
	return next_connection
	

func get_next_level(id, channel):
	var connections = get_next_connections(id, channel)
	if connections.size() == 0:
		return null
		
	var index = randi() % connections.size()
	var next_connection = connections[index]
	var next_node = get_level_node(next_connection.TO_ID)
	if next_node is LevelManagerWaypoint:
		next_connection = get_next_level_waypoint(next_node)
		
	return next_connection


func get_start_waypoint_node():
	var start_waypoints = []
	for x in WAYPOINTS:
		if x.NAME == "Start":
			start_waypoints.append(x)
			
	var i = randi() % start_waypoints.size()
	return start_waypoints[i]
