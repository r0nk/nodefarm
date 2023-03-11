extends Line2D

export var from :NodePath
export var to :NodePath
var state = false

signal toggle(state)

func _ready():
	deactivate()

func activate():
	set_state(true)

func deactivate():
	set_state(false)

func set_state(value):
	if state != value:
		emit_signal("toggle",state)
	state = value
	if state:
		default_color="00FFFF"
	else:
		default_color="003333"

