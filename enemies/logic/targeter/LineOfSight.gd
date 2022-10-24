extends EnemyTargeter
class_name ETLineOfSight

func locate(enemy: Enemy, delta: float) -> Vector2:
	if not "time_since_last_found" in enemy.properties:
		enemy.properties["time_since_last_found"] = 0
		
	if not "last_adjustment" in enemy.properties:
		enemy.properties["last_adjustment"] = 1
		
	enemy.properties["time_since_last_found"] += delta
	
	var eyeSight = enemy.get_node("EyeSight") as RayCast2D
	
	# If we can't see anything then just keep moving ahead
	if not eyeSight.is_colliding():
		enemy.global_rotation += (PI / 4) * delta * enemy.properties["last_adjustment"]
		var dir = Vector2.UP.rotated(enemy.global_rotation)
		return dir + enemy.global_position
		
	var infront_object = eyeSight.get_collider()
	
	# the player is in front, get em
	if infront_object is Player:
		enemy.properties["time_since_last_found"] = 0
		return infront_object.global_position
		
	if enemy.properties["time_since_last_found"] >= 2:
		enemy.properties["time_since_last_found"] = 0
		if randf() > 0.5:
			enemy.properties["last_adjustment"] = 1
		else:
			enemy.properties["last_adjustment"] = -1

	# whatever in front is not a good thing
	enemy.global_rotation += (PI / 2) * delta * enemy.properties["last_adjustment"]
	var dir = Vector2.UP.rotated(enemy.global_rotation)
	return dir + enemy.global_position
