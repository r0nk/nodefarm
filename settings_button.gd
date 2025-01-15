extends Button

func activate():
	$"../settings".visible=true

func _ready():
	pressed.connect(activate)


