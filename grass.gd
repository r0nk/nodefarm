extends StaticBody3D

func reproduce(at):
	var gs = load("res://grass.tscn")
	var gsi = gs.instantiate()
	get_parent().add_child(gsi)
	gsi.rotation.y=randf()*360.0
	gsi.global_position=at
	for area in gsi.get_node("personal").get_overlapping_areas():
		if area.name=="personal":
			queue_free()

func _process(delta):
	if(randf()>0.005):
		return
	$seed_rotator.rotation.y=randf()*360.0
	if $seed_rotator/seedcast.is_colliding():
		reproduce($seed_rotator/seedcast.get_collision_point())

	for area in $personal.get_overlapping_areas():
		if area.name=="personal":
			queue_free()
