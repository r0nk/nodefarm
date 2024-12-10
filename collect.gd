extends Area3D

@export var target_group:StringName

func _process(delta):
	for body in get_overlapping_bodies():
		if(body.is_in_group(target_group)):
			$"../".add(body.resource)
			body.queue_free()
			$sfx.play()


