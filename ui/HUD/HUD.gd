extends CanvasLayer

export (NodePath) var INVENTORY_PATH

const InvItem := preload("res://ui/InvItem/InvItem.tscn")

onready var CoinsLabel := $Counters/CoinsContainer/CoinsLabel
onready var CrystalsLabel := $Counters/CrystalsContainer/CrystalsLabel

onready var WeaponNode := $Weapon
onready var ArtifactsNode := $Artifacts

func get_inventory() -> Inventory:
	var inventory = get_node(INVENTORY_PATH)
	if is_instance_valid(inventory):
		return inventory
	return null

func _ready():
	var inventory = get_inventory()
	
	var artifact_slots = inventory.MAX_ARTIFACT_SLOTS
	ArtifactsNode.columns = artifact_slots
	
	WeaponNode.INVENTORY = inventory.EQUIPPED_WEAPON
	WeaponNode.SLOT = 0
	
	for x in range(0, artifact_slots):
		var invItem = InvItem.instance()
		invItem.INVENTORY = inventory.EQUIPPED_ARTIFACTS
		invItem.SLOT = x
		invItem.ONLY_ARTIFACT = true
		ArtifactsNode.add_child(invItem)
		
	ArtifactsNode.set_anchors_and_margins_preset(Control.PRESET_CENTER_TOP, 0, 10)

func _process(_delta):
	var inventory = get_inventory()

	CoinsLabel.text = str(inventory.get_coins())
	CrystalsLabel.text = str(inventory.get_crystals())
