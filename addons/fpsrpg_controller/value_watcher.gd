extends Label

@export var target:Node
@export var variable:String

func _process(delta: float) -> void:
	text = str(target.get(variable))
