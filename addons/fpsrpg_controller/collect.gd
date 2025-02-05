extends Area3D

@export var target_group:StringName
@export var target_inventory:Node

func _process(delta):
	for body in get_overlapping_bodies():
		if(body.is_in_group(target_group)):
			target_inventory.add(body.resource)
			body.queue_free()
			$sfx.play()


