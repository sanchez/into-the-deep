extends Label


@export var AMOUNT: float = 0


var floating_dir = Vector2.ZERO
var speed = 200


func _ready():
	var amount = abs(AMOUNT)
	
	text = str(ceil(amount))
	var x = randf_range(-0.5, 0.5)
	var y = randf_range(-0.5, -1)
	speed = clamp(amount * 5, 5, 200)
	floating_dir = Vector2(x, y)

func _process(delta):
	position += floating_dir * delta * speed
