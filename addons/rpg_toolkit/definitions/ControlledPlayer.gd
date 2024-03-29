extends CharacterBody2D
class_name ControlledPlayer

@export var MAX_SPEED := 300.0
@export var ACCELERATION := 40.0
@export var FRICTION := 0.8
@export var WEAPON_SCALE := 1.0

@export_node_path(AnimationPlayer) var ANIMATION_PLAYER_PATH

@onready var ANIMATION_PLAYER : AnimationPlayer = get_node(ANIMATION_PLAYER_PATH)
@onready var HealthNode := $Health
@onready var InventoryNode := $Inventory

@export var IDLE_SUFFIX = "_idle"
@export var DIRECTION_LOOKUP: Array[ControlledPlayerAngleAnimation] = []


var _last_dir_angle = Vector2.DOWN.angle()


func attack(attack_angle: float):
	var invItem = InventoryNode.get_item_in_slot(0)
	if not is_instance_valid(invItem):
		return

	if not invItem is WeaponInvItem:
		return
		
	var parameters = {
		"rotation": (attack_angle + PI/2),
		"position": Vector2(0, -6),
		"scale": WEAPON_SCALE
	}
	
	invItem.attack(self, parameters)


func _physics_process(delta):
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var new_dir_angle = direction.angle()
	
	velocity = velocity.slerp(Vector2.ZERO, FRICTION)
	
	var is_idle = direction.length_squared() <= 0.0001
	if not is_idle:
		var new_velocity = direction * ACCELERATION
		velocity += new_velocity
		
	else:
		new_dir_angle = _last_dir_angle
		
	if is_instance_valid(ANIMATION_PLAYER):
		var animation_lookup = ""
		var closest_angle = 2 * PI
		for x in DIRECTION_LOOKUP:
			var angle_offset = abs(new_dir_angle - (x.ANGLE * 0.01745329))
			if (angle_offset < closest_angle):
				animation_lookup = x.ANIMATION
				closest_angle = angle_offset
		_last_dir_angle = new_dir_angle
		
		var actual_velocity = get_real_velocity()
		var actual_is_idle = actual_velocity.length_squared() <= 1
		#print(actual_velocity.length_squared())
		#ANIMATION_PLAYER.playback_speed = (actual_is_idle == is_idle) if 1 else 0.8
		
		if is_idle or actual_is_idle:
			animation_lookup += "_idle"
		else:
			animation_lookup += "_walk"
			
		if ANIMATION_PLAYER.has_animation(animation_lookup):
			ANIMATION_PLAYER.play(animation_lookup)
			
	if Input.is_action_just_pressed("attack"):
		attack(new_dir_angle)
			
	velocity = velocity.round()
	move_and_slide()


func get_world_manager() -> WorldManager:
	var p = get_parent()
	while not p is WorldManager:
		p = p.get_parent()
	return p


func die():
	var world_manager = get_world_manager()
	world_manager.set_world("OverWorld", "")
	HealthNode.reset()
