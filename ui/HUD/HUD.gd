extends CanvasLayer

export (NodePath) var INVENTORY_PATH

onready var CoinsLabel := $Counters/CoinsContainer/CoinsLabel
onready var CrystalsLabel := $Counters/CrystalsContainer/CrystalsLabel
onready var WeaponNode := $Weapon

func get_inventory() -> Inventory:
	var inventory = get_node(INVENTORY_PATH)
	if is_instance_valid(inventory):
		return inventory
	return null

func _ready():
	var inventory = get_inventory()
	
	WeaponNode.INVENTORY = inventory.EQUIPPED_WEAPON
	WeaponNode.SLOT = 0

func _process(delta):
	var inventory = get_inventory()

	CoinsLabel.text = str(inventory.get_coins())
	CrystalsLabel.text = str(inventory.get_crystals())
