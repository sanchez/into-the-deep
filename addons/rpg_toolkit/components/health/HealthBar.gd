extends Node2D


@export var ICON_SIZE = 16
@export var ICON_SCALE = 1.0
@export var ICON_SPACING = 2


var health: Health
var position_offset := Vector2.ZERO

@onready var BarNode := $Bar
@onready var BuffStart := $BuffStart


func _ready():
	position_offset = position
	
	var parent = get_parent()
	if parent is Health:
		health = parent
	else:
		push_error("Failed to find health class for health bar")
		
	health.connect("on_update", queue_redraw)


func _draw():
	var icon_top = ICON_SPACING * ICON_SCALE
	var icon_left = ICON_SPACING * ICON_SCALE
	for buff_stack in health.STATUS:
		if not is_instance_valid(buff_stack):
			continue
			
		if buff_stack.STACK == 0:
			continue
			
		var buff = buff_stack.BUFF
		if not is_instance_valid(buff) or not is_instance_valid(buff.ICON):
			continue
		
		var position = BuffStart.position
		position.x += icon_left
		position.y += icon_top
		icon_left += (ICON_SIZE + ICON_SPACING) * ICON_SCALE
		
		var icon_rect = Rect2(position, Vector2(ICON_SIZE * ICON_SCALE, ICON_SIZE * ICON_SCALE))
		
		draw_texture_rect(buff.ICON, icon_rect, false)


func draw_health_bar():
	var ratio = clamp(health.HEALTH / health.MAX_HEALTH, 0, 1)
	BarNode.scale.x = ratio


func _process(delta):
	global_position = owner.global_position + position_offset
	draw_health_bar()
