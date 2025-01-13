extends CharacterBody3D

@export var resource:Item

func _ready():
	resource=resource.duplicate()
#	print(name,": ",resource.id)
	$sprite.texture=resource.texture

func _process(delta):
	rotation_degrees.y+=delta*90
	if not is_on_floor():
		velocity.y-=10*delta
	else:
		velocity.y=0
	move_and_slide()
