extends Node
class_name BaseWorld

signal on_next_level(world)

func next_level(world: PackedScene):
	emit_signal("on_next_level", world)
	
func get_player_spawn():
	var spawn = get_node("Spawn")
	return spawn.global_position

func is_damagable(node: Node):
	var health = node.find_node("HealthStatus")
	return is_instance_valid(health)

func get_players():
	var players = []
	for x in get_children():
		if x is Player:
			players.append(x)
			
	return players
	
func get_damagable_within_radius(position: Vector2, radius: float):
	var res = []
	var squared_radius = radius * radius
	
	var children = get_children()
	for x in children:
		if is_damagable(x):
			var dist = position.distance_squared_to(x.global_position)
			if dist <= squared_radius:
				res.append(x)
		
	return res
	
func get_enemies():
	var enemies = []
	for x in get_children():
		pass
		#if x is Enemy:
		#	enemies.append(x)
			
	return enemies
