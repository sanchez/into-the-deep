tool
extends GraphNode


signal on_delete()

export (Resource) var DEFINITION

func _init():
	DEFINITION = LevelManagerWaypoint.new()


func _on_GraphNode_close_request():
	emit_signal("on_delete")


func _on_GraphNode_resize_request(new_minsize):
	rect_min_size = new_minsize


func _on_GraphNode_offset_changed():
	DEFINITION.POSITION = offset
