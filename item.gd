extends CharacterBody3D

@export var resource:Resource

func _process(delta):
	rotation_degrees.y+=delta*90
	if not is_on_floor():
		velocity.y-=2*delta
	else:
		velocity.y=0
	move_and_slide()
