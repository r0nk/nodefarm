extends Area3D

@export var scene:PackedScene

@export var max_spawned=20

var spawned = []

func spawn():
	assert(scene,"No scene to spawn")
	var instance = scene.instantiate()
	var extents = $area.shape.size/2.0
	var p = Vector3(randf_range(-extents.x,extents.x),
	randf_range(-extents.y,extents.y),
	randf_range(-extents.z,extents.z))
	instance.position+=p
	add_child(instance)
	if(spawned.size()>max_spawned):
		var f = spawned.pop_back()
		f.queue_free()
	spawned.push_front(instance)
