extends StaticBody3D

var rtimer

func reproduce(at):
	var gs = load("res://grass.tscn")
	var gsi = gs.instantiate()
	get_parent().add_child(gsi)
	gsi.rotation.y=randf()*360.0
	gsi.global_position=at
	for area in gsi.get_node("personal").get_overlapping_areas():
		if area.name=="personal":
			queue_free()

func _ready():
	rtimer= Timer.new()
	rtimer.wait_time=randf_range(5.0,10.0)
	add_child(rtimer)
	rtimer.timeout.connect(update)
	rtimer.start()

func spawn_grasshopper():
	var gs = load("res://grasshopper.tscn")
	var gsi = gs.instantiate()
	get_parent().add_child(gsi)
	gsi.rotation.y=randf()*360.0
	gsi.global_position=global_position

func update():
	$seed_rotator.rotation.y=randf()*360.0
	if $seed_rotator/seedcast.is_colliding():
		reproduce($seed_rotator/seedcast.get_collision_point())

	for area in $personal.get_overlapping_areas():
		if area.name=="personal":
			if(randf()<0.1):
				spawn_grasshopper()
			queue_free()
