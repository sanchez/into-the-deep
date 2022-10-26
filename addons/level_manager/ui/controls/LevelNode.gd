tool
extends GraphNode

export (String) var FILE_PATH

var channels = []

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
		var label = Label.new()
		label.text = channel
		add_child(label)
