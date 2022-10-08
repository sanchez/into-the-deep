extends Player

export (int) var ACCELERATION = 500
export (int) var MAX_SPEED = 90
export (float) var FRICTION = 7.0

var motion := Vector2.ZERO

onready var HealthStatus := $HealthStatus
onready var Inventory := $Inventory

func _physics_process(delta):
	process_attack()
	
	var inputVector = get_input()
	motion = apply_motion(inputVector, delta)
	motion = apply_friction(inputVector)
	
	apply_rotation(inputVector)
	
	move()
	
func process_attack():
	if Input.is_action_just_pressed("attack"):
		Inventory.attack()
	
func apply_rotation(inputVector: Vector2):
	if inputVector.length_squared() > 0:
		rotation = inputVector.angle() + (PI / 2)
	
func apply_motion(inputVector: Vector2, delta: float):
	var newMotion = motion + (inputVector * ACCELERATION * delta)
	return newMotion.limit_length(MAX_SPEED)
	
func apply_friction(inputVector: Vector2):
	if inputVector.length_squared() == 0:
		return motion.move_toward(Vector2.ZERO, FRICTION)
	return motion
	
func get_input():
	var inputVector = Vector2.ZERO
	
	inputVector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	inputVector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	return inputVector.normalized()
	
func move():
	motion = move_and_slide(motion)

func take_damage(damage: Damage):
	HealthStatus.on_hit(damage)
