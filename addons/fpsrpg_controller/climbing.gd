extends Node3D

var active = false

#the thing actually being climbed
var surface

func ray_hits_climbable(ray):
	assert(ray)
	if ray.is_colliding() and ray.get_collider().is_in_group("climbable"):
		return true
	return false

func _process(delta: float) -> void:
	if not active:
		var climbable = [$start_ray].map(ray_hits_climbable).max()
		$label.visible=climbable
		#TODO make this a hotkey
		active=climbable
		$label.text="[wave]climbing...[/wave]"
	else:
		get_parent().velocity*=0
		if(!ray_hits_climbable($start_ray)):
			active=false
			if Input.is_action_pressed("move_forward"):
				#hop up
				get_parent().velocity.y=50
				get_parent().move_and_slide()
				return
		if Input.is_action_pressed("jump"):
			active=false
		if Input.is_action_pressed("move_forward"):
			get_parent().velocity.y=15
		get_parent().move_and_slide()
