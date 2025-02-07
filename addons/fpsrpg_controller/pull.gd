extends Area3D

@export var speed:float = 50
@export var target_group:StringName

func _process(delta):
	for body in get_overlapping_bodies():
		if(body.is_in_group(target_group)):
			var d = body.global_position-global_position
			d=d.normalized()
			body.position-=d*delta*speed

