extends BuffAttribute
class_name BA_RemoveBuff

func invoke(buff: Buff, health: Health, _damage: Damage, _source):
	health.remove_buff(buff)
