extends Area3D

@export var once_only=false
var disabled=false

signal switched_on
signal switched_off
signal switched

# (on,off) = (true,false)
var state:bool:
	set(v):
		state=v
		if state:
			$handle.rotation_degrees.z=-45
		else:
			$handle.rotation_degrees.z=-135

func interact():
	if disabled:
		return
	state=!state
	switched.emit()
	if once_only:
		disabled=true
	if state:
		switched_on.emit()
	else:
		switched_off.emit()
