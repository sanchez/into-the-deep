tool
extends EditorPlugin

const Editor := preload("res://addons/level_manager/ui/Editor.tscn")
const LevelCollection := preload("res://addons/level_manager/definitions/LevelCollection.gd")
var editor_instance

func _enter_tree():
	add_custom_type("LevelCollection", "Resource", preload("res://addons/level_manager/definitions/LevelCollection.gd"), get_plugin_icon())
	
	if Engine.is_editor_hint():
		# TODO: Add some sort of import plugin I think?
		
		print("Creating Level Manager")
		editor_instance = Editor.instance()
		get_editor_interface().get_editor_viewport().add_child(editor_instance)
		make_visible(false)
		

func _exit_tree():
	remove_custom_type("LevelCollection")
	
	if is_instance_valid(editor_instance):
		editor_instance.queue_free()

func has_main_screen():
	return true
	
func handles(object):
	return object is LevelCollection
	
func edit(object):
	if is_instance_valid(editor_instance):
		editor_instance.edit(object)
	
func apply_changes():
	if is_instance_valid(editor_instance):
		editor_instance.save()

func make_visible(visible):
	if is_instance_valid(editor_instance):
		editor_instance.visible = visible

func get_plugin_name():
	return "Level Manager"

func get_plugin_icon():
	return get_editor_interface().get_base_control().get_icon("Node", "EditorIcons")
