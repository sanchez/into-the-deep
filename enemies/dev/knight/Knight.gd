extends Enemy

var ATTACK_RANGE = 40
var attack_charge = 0

onready var Inventory := $Inventory

func is_player_in_range(world: BaseWorld):
	var players = world.get_players()
	var closest_player = Utils.find_closest_node(get_position(), players)
	if is_instance_valid(closest_player):
		var dist = (closest_player.global_position - get_position()).length()
		return dist < ATTACK_RANGE
	return false

func think(delta: float, world: BaseWorld):
	if is_player_in_range(world):
		attack_charge += delta
		if attack_charge >= 1:
			attack_charge = 0
			Inventory.attack()
			
	else:
		if attack_charge > 0:
			attack_charge -= delta / 2
		var target = get_target(world)
		move_towards(target, delta)
	
		# if we are close to our search then we want to get a new search target
		var search_dist = (global_position - last_target).length_squared()
		if search_dist < (MAX_SPEED * MAX_SPEED):
			last_target = null


func _on_HealthStatus_on_death():
	queue_free()
