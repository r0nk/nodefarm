extends Node2D

onready var parent = get_parent()

export var speed = 100

export var friction = 0.15

export var velocity = Vector2(0,0)

var input_direction = Vector2(0,0)

func _process(delta):
	velocity += (input_direction*speed)
	velocity *= 1-friction
	parent.move_and_slide(velocity)

func set_direction(direction):
	input_direction=direction
	input_direction.y*=-1
