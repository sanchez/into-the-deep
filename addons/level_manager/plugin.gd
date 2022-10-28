tool
extends EditorPlugin

const Editor := preload("res://addons/level_manager/ui/Editor.tscn")
var editor_instance

func _enter_tree():
	print("Creating Level Manager")
	editor_instance = Editor.instance()
	get_editor_interface().get_editor_viewport().add_child(editor_instance)
	make_visible(false)

func _exit_tree():
	if is_instance_valid(editor_instance):
		editor_instance.queue_free()

func has_main_screen():
	return true

func make_visible(visible):
	if is_instance_valid(editor_instance):
		editor_instance.visible = visible

func get_plugin_name():
	return "Level Manager"

func get_plugin_icon():
	return get_editor_interface().get_base_control().get_icon("Node", "EditorIcons")

func save_external_data():
	if is_instance_valid(editor_instance):
		editor_instance.save()
