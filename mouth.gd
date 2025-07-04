extends Area3D

@export var target_group = "grass"

signal eat(calories)

func _process(delta):
	for area in get_overlapping_areas():
		if(area.get_parent().is_in_group("grass")):
			area.get_parent().queue_free()
			eat.emit(20)

