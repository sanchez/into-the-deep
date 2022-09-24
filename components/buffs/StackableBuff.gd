extends Buff
class_name StackableBuff

export (int) var MAX_STACK = -1

func on_apply(_health):
	if MAX_STACK == -1 or not stack >= MAX_STACK:
		set_stack(stack + 1)
