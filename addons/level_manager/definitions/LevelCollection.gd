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


func get_next_connections(id, channel):
	var res = []
	
	for x in CONNECTIONS:
		if x.FROM_ID == id and x.FROM_CHANNEL == channel:
			res.append(x)
	
	return res
	

func get_next_level(id, channel):
	var connections = get_next_connections(id, channel)
	if connections.size() == 0:
		return null
		
	var index = randi() % connections.size()
	return connections[index]
