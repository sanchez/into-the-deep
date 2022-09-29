extends Area2D
class_name Inventory

var equipped_weapon: Weapon = null
var equipped_artifacts = []
var spare_slots: Array = []

var coins: Currency
var crystals: Currency

export (int) var MAX_ARTIFACT_SLOTS = 6
export (int) var MAX_SPARE_SLOTS = 16
export (bool) var CAN_SHOW = false

func _ready():
	coins = Currency.new()
	crystals = Currency.new()
	for x in range(0, MAX_SPARE_SLOTS):
		spare_slots.append(null)

func check_pickup():
	return Input.is_action_pressed("interact")
	
func get_intersecting_item() -> DroppedItem:
	for x in get_overlapping_areas():
		if x is DroppedItem:
			return x
	return null
	
# TODO: What need to do some sort of balancing thing here
func get_existing_stack(item: Item):
	if item.MAX_STACK == 1:
		return null
	for x in spare_slots:
		if not is_instance_valid(x):
			continue
		if x.KEY == item.KEY:
			if x.stack_count < x.MAX_STACK:
				return x
	return null
	
func get_spare_slot_index():
	for x in range(0, MAX_SPARE_SLOTS):
		if spare_slots[x] == null:
			return x
	return -1
	
func process_currency_pickup(item: Currency):
	match item.KEY:
		"Coin":
			coins.AMOUNT += item.AMOUNT
		"Crystal":
			crystals.AMOUNT += item.AMOUNT
	
func process_item_pickup():
	var item = get_intersecting_item()
	if item != null:
		if item is Currency:
			process_currency_pickup(item)
			item.queue_free()
			return
		var existing_stack = get_existing_stack(item.ITEM)
		if existing_stack == null:
			var new_index = get_spare_slot_index()
			spare_slots[new_index] = item
		else:
			existing_stack.stack += item.stack_count
			
		item.queue_free()
		
func process_inventory_manage():
	if Input.is_action_just_pressed("inventory"):
		print("Inventory")

func _process(delta):
	process_item_pickup()
	process_inventory_manage()
