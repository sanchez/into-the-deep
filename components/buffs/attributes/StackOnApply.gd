extends BuffAttribute
class_name BAStackOnApply

export (int) var MAX_STACK = -1

func on_apply(buff, _health):
	if buff.stack < MAX_STACK:
		buff.stack += 1
