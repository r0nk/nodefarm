extends CharacterBody3D

var destination

@export var speed = 10

func jump():
	velocity=global_transform.basis.z*10
	velocity.y=4
	move_and_slide()

func change_destination():
	jump()
	destination=position+(Vector3(randf_range(-1,1),0,randf_range(-1,1))*10)

func _process(delta):
	look_at(destination)
	if not is_on_floor():
		velocity.y-=9.8*delta
	else:
		velocity*=0
	move_and_slide()

func _ready():
	change_destination()
	var timer = Timer.new()
	add_child(timer)
	timer.wait_time=1
	timer.timeout.connect(change_destination)
	timer.start()
