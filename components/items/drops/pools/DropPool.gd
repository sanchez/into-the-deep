extends Resource
class_name DropPool

export (Array, Resource) var POSSIBLE_DROPS

func get_drops():
	var certain_items = []
	var weighted_items = []
	var total_weight = 0
	
	for x in POSSIBLE_DROPS:
		if x.WEIGHT >= 1:
			certain_items.append(x)
		else:
			total_weight += x.WEIGHT
			weighted_items.append(x)
			
	var res_num = rand_range(0, total_weight)
	for x in weighted_items:
		if res_num <= x.WEIGHT:
			certain_items.append(x)
			break
		res_num -= x.WEIGHT
		
	var total_items = []
	for x in certain_items:
		total_items.append_array(x.get_items())
	return total_items
