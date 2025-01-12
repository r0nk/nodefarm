extends Button

func _ready():
	pressed.connect(pressed_button)

func pressed_button():
	get_tree().quit()
