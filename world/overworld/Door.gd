extends DoorWay


@onready var AnimationPlayerNode := $AnimationPlayer


func activate_door(_player):
	AnimationPlayerNode.play("ACTIVATE")
