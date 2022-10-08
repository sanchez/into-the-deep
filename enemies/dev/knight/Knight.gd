extends Enemy

var ATTACK_RANGE = 40

onready var Inventory := $Inventory

func process_attack(world: BaseWorld):
	var players = world.get_players()
	var closest_player = Utils.find_closest_node(get_position(), players)
	if is_instance_valid(closest_player):
		var dist = (closest_player.global_position - get_position()).length()
		if dist < ATTACK_RANGE:
			Inventory.attack()

func think(delta: float, world: BaseWorld):
	process_attack(world)
	
	var target = get_target(world)
	move_towards(target, delta)
	
	# if we are close to our search then we want to get a new search target
	var search_dist = (global_position - last_target).length_squared()
	if search_dist < (MAX_SPEED * MAX_SPEED):
		last_target = null


func _on_HealthStatus_on_death():
	queue_free()
