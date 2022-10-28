tool
extends GraphNode

signal on_delete()

export (String) var FILE_PATH

var output_channels = []
var input_channels = []

func register_channel(input_channel, output_channel):
	var index = get_child_count()
	var input_name = input_channel if input_channel != null else ""
	var output_name = output_channel if output_channel != null else ""
	
	var container = HBoxContainer.new()
	container.grow_horizontal = Control.GROW_DIRECTION_BOTH
	container.grow_vertical = Control.GROW_DIRECTION_BOTH
	container.size_flags_horizontal = 3
	
	var leftLabel = Label.new()
	leftLabel.text = input_name
	leftLabel.size_flags_horizontal = 3
	container.add_child(leftLabel)
	
	var rightLabel = Label.new()
	rightLabel.text = output_name
	container.add_child(rightLabel)
	
	add_child(container)
	set_slot(index, input_channel != null, 0, Color.white, output_channel != null, 0, Color.white)
	

func load_channels(node: Node):
	if node is LevelManagerDoor:
		if not output_channels.has(node.CHANNEL):
			output_channels.append(node.CHANNEL)
			return
			
	if node is LevelManagerSpawn:
		if not input_channels.has(node.CHANNEL):
			input_channels.append(node.CHANNEL)
			return
	
	for x in node.get_children():
		load_channels(x)


func _ready():
	var scene = load(FILE_PATH)
	var instance = scene.instance()
	title = FILE_PATH
	
	load_channels(instance)
	
	var max_index = max(output_channels.size(), input_channels.size())
	for x in range(0, max_index):
		var input_channel = input_channels[x] if x < input_channels.size() else null
		var output_channel = output_channels[x] if x < output_channels.size() else null
		register_channel(input_channel, output_channel)


func _on_LevelNode_resize_request(new_minsize):
	rect_min_size = new_minsize


func _on_LevelNode_close_request():
	emit_signal("on_delete")
