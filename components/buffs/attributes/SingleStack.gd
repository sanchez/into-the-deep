extends BuffAttribute
class_name BASingleStack

export (int) var INITIAL_STACK = 1

func on_apply(buff, _health):
	buff.stack = INITIAL_STACK
