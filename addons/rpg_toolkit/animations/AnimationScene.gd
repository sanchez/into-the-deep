extends RPG_Animation
class_name RPG_AnimationScene

@export var SCENE: PackedScene

func play(source: Node, parameters: Dictionary):
	var scene = SCENE.instantiate()
	
	if parameters.has("rotation"):
		scene.rotation = parameters["rotation"]
		
	if parameters.has("position"):
		scene.position = parameters["position"]
	
	source.add_child(scene)
