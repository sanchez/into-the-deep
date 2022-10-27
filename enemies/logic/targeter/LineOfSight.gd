extends EnemyTargeter
class_name ETLineOfSight

var search_dirs = {}

func locate(enemy: Enemy, _delta: float) -> Vector2:
	var enemy_id = enemy.get_instance_id()
	
	if not search_dirs.has(enemy_id):
		search_dirs[enemy_id] = 1 if randf() > 0.5 else -1
	
	var eyeSight = enemy.get_node("EyeSight") as RayCast2D
	
	# If we can't see anything then just keep moving ahead
	if not eyeSight.is_colliding():
		search_dirs[enemy_id] = 1 if randf() > 0.5 else -1
		var dir = Vector2.UP.rotated(enemy.global_rotation)
		return dir + enemy.global_position
		
	var infront_object = eyeSight.get_collider()
	
	# the player is in front, get em
	if infront_object is Player:
		return infront_object.global_position
		
	# whatever in front is not a good thing
	enemy.global_rotation += (PI / 16) * search_dirs[enemy_id]
	var dir = Vector2.UP.rotated(enemy.global_rotation)
	return dir + enemy.global_position
