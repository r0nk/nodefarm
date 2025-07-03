extends CharacterBody3D

var destination

@export var speed = 10

func change_destination():
	destination=position+(Vector3(randf(),0,randf())*10)

func _process(delta):
	look_at(destination)
	velocity=global_transform.basis.z*10
	if not is_on_floor():
		velocity.y=-9.8
	move_and_slide()

func _ready():
	change_destination()
	var timer = Timer.new()
	add_child(timer)
	timer.wait_time=1
	timer.timeout.connect(change_destination)
	timer.start()
