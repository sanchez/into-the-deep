extends Node
class_name BaseWorld

func get_players():
	var players = []
	for x in get_children():
		if x is Player:
			players.append(x)
			
	return players
	
func get_enemies():
	var enemies = []
	for x in get_children():
		pass
		#if x is Enemy:
		#	enemies.append(x)
			
	return enemies
