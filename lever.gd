extends Area3D

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
	state=!state
	switched.emit()
	if state:
		switched_on.emit()
	else:
		switched_off.emit()
