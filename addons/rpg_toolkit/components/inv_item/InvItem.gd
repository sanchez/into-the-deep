extends Area2D
class_name InvItem


@export var KEY := ""
@export var STACK := 1
@export var MAX_STACKS := 1
@export var ICON: Texture2D


func try_stack(item: InvItem):
	if KEY != item.KEY:
		return false
		
	if MAX_STACKS < 0 or MAX_STACKS > STACK:
		STACK += 1
		return true
		
	return false
