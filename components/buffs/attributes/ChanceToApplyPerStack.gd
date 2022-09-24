extends BAChanceToApply
class_name BAChanceToApplyPerStack

func roll(buff):
	for x in range(0, buff.stack):
		var r = randf()
		if r <= CHANCE:
			return true
			
	return false
