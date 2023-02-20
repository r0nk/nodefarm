extends Area2D

var starting_point = Vector2(0,0)
var dragging = false

func selected():
	get_overlapping_bodies()

func _process(delta):
	var mp=get_viewport().get_mouse_position()
	if Input.is_action_just_pressed('start_selection_box'):
		starting_point = mp
		position = starting_point
	if Input.is_action_pressed('start_selection_box'):
		var mid = (starting_point - mp)/2
		$cs.scale = mid
		$cs.position = -mid
		dragging=true
	else:
		if(dragging):
			selected()
		dragging=false
		$cs.scale.x = 0
		$cs.scale.y = 0

