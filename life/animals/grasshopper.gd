extends CharacterBody3D

var destination

@export var speed = 10

@export var jump_force=4

func jump():
	velocity=global_transform.basis.z*10
	velocity.y=jump_force
	move_and_slide()

func change_destination():
	jump()
	destination=position+(Vector3(randf_range(-1,1),0,randf_range(-1,1))*10)
	if $jump_timer:
		$jump_timer.wait_time=1.0+randf()

func _process(delta):
	if not destination:
		change_destination()
	look_at(destination)
	if not is_on_floor():
		velocity.y-=9.8*delta
	else:
		velocity*=0
	move_and_slide()
