extends EnemyTargeter
class_name ETLineOfSight

func locate(enemy: Enemy, delta: float) -> Vector2:
	var eyeSight = enemy.get_node("EyeSight") as RayCast2D
	
	# If we can't see anything then just keep moving ahead
	if not eyeSight.is_colliding():
		var dir = Vector2.UP.rotated(enemy.global_rotation)
		return dir + enemy.global_position
		
	var infront_object = eyeSight.get_collider()
	
	# the player is in front, get em
	if infront_object is Player:
		return infront_object.global_position

	# whatever in front is not a good thing
	enemy.global_rotation += (PI / 4) * delta
	var dir = Vector2.UP.rotated(enemy.global_rotation)
	return dir + enemy.global_position
