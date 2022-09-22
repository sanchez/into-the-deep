extends Enemy

var SEARCH_RANGE = 200
var ATTACK_RANGE = 30
var ATTACK_AMOUNT = 3

onready var Attack := $Attack
onready var HealthStatus := $HealthStatus
onready var Particles2D := $Particles2D

var last_target = Vector2.ZERO
var last_position = Vector2.ZERO

func get_target(world: BaseWorld) -> Vector2:
	var players = world.get_players()
	var closest_player = Utils.find_closest_node(get_position(), players)
	
	if last_target == null:
		get_new_random_location()
		
	if closest_player == null:
		return last_target
	
	return closest_player.global_position

func get_new_random_location():
	var search_vect = Vector2(rand_range(-1, 1), rand_range(-1, 1)).normalized() * SEARCH_RANGE
	var new_target = search_vect + global_position
	last_target = new_target
	
func attack(target):
	Particles2D.restart()
	Particles2D.emitting = true
	
func process_attack(world: BaseWorld):
	var players = world.get_players()
	var closest_player = Utils.find_closest_node(get_position(), players)
	if closest_player != null:
		var dist = (closest_player.global_position - get_position()).length()
		if dist < ATTACK_RANGE:
			var slowedBuff = BuffSlowed.new()
			var damage = Damage.new(ATTACK_AMOUNT, [slowedBuff])
			Attack.attack(closest_player, damage)

func think(delta: float, world: BaseWorld):
	process_attack(world)
	
	var target = get_target(world)
	if Attack.can_attack(): # if we have attacked and in our cooldown, I don't think we should move
		move_towards(target, delta)
	
	# if we are close to our search then we want to get a new search target
	var search_dist = (global_position - last_target).length_squared()
	if search_dist < (MAX_SPEED * MAX_SPEED):
		last_target = null
	
	# if we are bairly moving then we want to find a new search
	#var dist = (global_position - last_position).length_squared()
	#if dist < 10:
	#	last_target = null
	
	last_position = global_position

func take_damage(damage: Damage):
	HealthStatus.on_hit(damage)
