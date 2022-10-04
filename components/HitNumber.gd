extends Node2D

var dir: Vector2
var SPEED = 100

onready var Label := $Label

export (int) var DAMAGE_AMOUNT

func _ready():
	dir = Vector2(rand_range(-1, 1), rand_range(-1, 1))
	Label.text = str(DAMAGE_AMOUNT)

func _process(delta):
	global_position += dir * delta * SPEED
