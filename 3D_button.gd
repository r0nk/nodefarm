extends Area3D

@export var once_only=false
var disabled=false

signal switched

func interact():
	if disabled:
		return
	switched.emit()
	$anim.stop()
	$anim.play("pressed")
	if once_only:
		disabled=true
