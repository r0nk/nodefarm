extends Button

@export var target: NodePath = "../settings"

func activate():
	get_node(target).visible=true

func _ready():
	pressed.connect(activate)


