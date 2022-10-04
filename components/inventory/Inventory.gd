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
export (bool) var CAN_PICKUP = false

func _ready():
	coins = Currency.new()
	coins.AMOUNT = 0
	
	crystals = Currency.new()
	crystals.AMOUNT = 0
	
	for x in range(0, MAX_SPARE_SLOTS):
		spare_slots.append(null)
		
func get_weapon():
	return equipped_weapon
	
func get_artifacts():
	return equipped_artifacts
	
func get_coins():
	return coins.AMOUNT
	
func get_crystals():
	return crystals.AMOUNT
	
func attack():
	var weapon = get_weapon()
	if not is_instance_valid(weapon):
		return
		
	if weapon.is_active(self.owner):
		weapon.on_trigger(self.owner)
	
func get_intersecting_item() -> DroppedItem:
	for x in get_overlapping_areas():
		if x is DroppedItem:
			return x
	return null
	
func try_place_item(item: Item) -> bool:
	if item is Currency:
		if item.KEY == "Crystal":
			crystals.AMOUNT += item.AMOUNT
			return true
		if item.KEY == "Coin":
			coins.AMOUNT += item.AMOUNT
			return true
		return false
	
	if item is Weapon and not is_instance_valid(equipped_weapon):
		equipped_weapon = item
		return true
		
	# try to fit the item in with existing stacks
	for x in spare_slots:
		if not is_instance_valid(x):
			continue
		if x.KEY == item.KEY:
			if x.stack_count < x.MAX_STACK:
				var diff = min(x.MAX_STACK - x.stack_count, item.stack_count)
				x.stack_count += diff
				item.stack_count -= diff
				
	if item.stack_count <= 0:
		return true
		
	# find an empty slot and assign it
	for x in range(0, spare_slots.size()):
		if not is_instance_valid(spare_slots[x]):
			spare_slots[x] = item
			return true
	
	return false
	
func process_currency_pickup(item: Currency):
	match item.KEY:
		"Coin":
			coins.AMOUNT += item.AMOUNT
		"Crystal":
			crystals.AMOUNT += item.AMOUNT
	
func process_item_pickup():
	var item = get_intersecting_item()
	if is_instance_valid(item):
		if try_place_item(item.ITEM):
			item.queue_free()
		
func process_inventory_manage():
	if Input.is_action_just_pressed("inventory"):
		print("Inventory")
		
func process_inventory(delta: float):
	if is_instance_valid(equipped_weapon):
		equipped_weapon.on_tick(self.owner, delta)
	for x in equipped_artifacts:
		if is_instance_valid(x):
			x.on_tick(self.owner, delta)
			
func process_tick(delta: float):
	if is_instance_valid(equipped_weapon):
		equipped_weapon.on_tick(owner, delta)
	for x in equipped_artifacts:
		if is_instance_valid(x):
			x.on_tick(owner, delta)

func _process(delta):
	process_tick(delta)
	if CAN_PICKUP:
		process_item_pickup()
	if CAN_SHOW:
		process_inventory_manage()
