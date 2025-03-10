extends CSGBox3D

var damage = 5
var damage_rr = 5

func get_damage():
	return damage+(randi()%damage_rr)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ! visible:
		return
	if Input.is_action_just_pressed("fire"):
		$laser_body.visible=true
		$fire_sfx.play()
		if $ray.is_colliding():
			for i in range($ray.get_collision_count()):
				var target = $ray.get_collider(i)
				if(target.has_method('hurt')):
					target.hurt(get_damage())
	else:
		$laser_body.visible=false
