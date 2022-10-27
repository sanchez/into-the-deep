tool
extends GraphNode

signal on_delete()

export (String) var FILE_PATH

var channels = []

func register_channel(channel_name):
	var index = get_child_count()
	var enable_left = index == 0
	
	var container = HBoxContainer.new()
	container.grow_horizontal = Control.GROW_DIRECTION_BOTH
	container.grow_vertical = Control.GROW_DIRECTION_BOTH
	container.size_flags_horizontal = 3
	
	var leftLabel = Label.new()
	leftLabel.text = ""
	if enable_left:
		leftLabel.text = "Input"
	leftLabel.size_flags_horizontal = 3
	container.add_child(leftLabel)
	
	var rightLabel = Label.new()
	rightLabel.text = channel_name
	container.add_child(rightLabel)
	
	add_child(container)
	set_slot(index, enable_left, 0, Color.white, true, 0, Color.white)
	

func find_channel(node: Node):
	if node is LevelManagerDoor:
		if not channels.has(node.CHANNEL):
			channels.append(node.CHANNEL)
			return
			
	for x in node.get_children():
		find_channel(x)


func _ready():
	var scene = load(FILE_PATH)
	var instance = scene.instance()
	title = FILE_PATH
	find_channel(instance)
	for channel in channels:
		register_channel(channel)


func _on_LevelNode_resize_request(new_minsize):
	rect_min_size = new_minsize


func _on_LevelNode_close_request():
	emit_signal("on_delete")
