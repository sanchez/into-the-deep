extends Buff
class_name BuffSlowed

func _init():
	key = "Slowed"
	icon = load("res://components/buffs/slowed.png")

func on_apply(health):
	var slowed_buff = health.get_buff(key)
	if slowed_buff == null:
		health.add_buff(self)
