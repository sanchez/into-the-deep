tool
extends GraphNode


signal on_delete()

onready var TextEditNode := $TextEdit

var output_channels = []
var input_channels = []


export (Resource) var DEFINITION

func _init():
	output_channels.append("main")
	input_channels.append("main")
	

func _ready():
	TextEditNode.text = DEFINITION.NAME
	property_list_changed_notify()


func _on_GraphNode_close_request():
	emit_signal("on_delete")


func _on_GraphNode_resize_request(new_minsize):
	rect_min_size = new_minsize


func _on_GraphNode_offset_changed():
	DEFINITION.POSITION = offset


func _on_TextEdit_text_changed():
	DEFINITION.NAME = TextEditNode.text
