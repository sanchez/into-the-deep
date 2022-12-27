extends CharacterBody2D
class_name ControlledPlayer

@export var MAX_SPEED := 300.0
@export var ACCELERATION := 60.0
@export var FRICTION := 0.8

@export_node_path(AnimationPlayer) var ANIMATION_PLAYER_PATH

@onready var ANIMATION_PLAYER : AnimationPlayer = get_node(ANIMATION_PLAYER_PATH)


var _direction_lookup = {
	Vector2.UP.angle(): "UP",
	(Vector2.UP + Vector2.RIGHT).angle(): "UP_RIGHT",
	Vector2.RIGHT.angle(): "RIGHT",
	(Vector2.RIGHT + Vector2.DOWN).angle(): "DOWN_RIGHT",
	Vector2.DOWN.angle(): "DOWN",
	(Vector2.DOWN + Vector2.LEFT).angle(): "DOWN_LEFT",
	Vector2.LEFT.angle(): "LEFT",
	(Vector2.LEFT + Vector2.UP).angle(): "UP_LEFT",
};

var _last_dir_angle = Vector2.DOWN.angle()


func _physics_process(delta):
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var new_dir_angle = direction.angle()
	
	velocity = velocity.slerp(Vector2.ZERO, FRICTION)
	
	var is_idle = direction.length_squared() <= 0.0001
	if not is_idle:
		var new_velocity = direction * ACCELERATION + velocity
		velocity += new_velocity
		
	else:
		new_dir_angle = _last_dir_angle
		
	if is_instance_valid(ANIMATION_PLAYER):
		var animation_lookup = ""
		for x in _direction_lookup.keys():
			if abs(new_dir_angle - x) < PI / 6:
				animation_lookup = _direction_lookup[x]
		_last_dir_angle = new_dir_angle
		if is_idle:
			animation_lookup += "_IDLE"
			
		if ANIMATION_PLAYER.has_animation(animation_lookup):
			ANIMATION_PLAYER.play(animation_lookup)
	
	move_and_slide()
