extends Area2D

export var force = 3000
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var bpush=Vector2(1,0).rotated(global_rotation)
	for body in get_overlapping_bodies():
		body.get_node("movement").velocity+=bpush*force*delta

