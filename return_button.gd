extends Button

func _ready():
	pressed.connect(p)

func p():
	get_parent().toggle()
