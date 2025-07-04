extends Node3D

var empty=true
var collected_old_parent

func collect(body):
	empty = false
	print("collecting ",body.name)
	body.reparent($captured)
	body.position=Vector3(0,0,0)
	body.process_mode=Node.PROCESS_MODE_DISABLED

func release():
	if empty:
		return

func activate():
	$sfx.play()
	if (not empty):
		return
	for body in $collection.get_overlapping_bodies():
		if body.is_in_group("jarable"):
			collect(body)
			break

