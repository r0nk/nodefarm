extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal activated()
signal deactivated()

func body_entered(body):
	emit_signal("activated")

func body_exited(body):
	emit_signal("deactivated")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
