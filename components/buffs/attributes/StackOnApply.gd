extends BuffAttribute
class_name BAStackOnApply

export (int) var MAX_STACK = -1

func on_apply(buff, _health):
	if buff.stack < MAX_STACK or MAX_STACK == -1:
		buff.stack += 1
