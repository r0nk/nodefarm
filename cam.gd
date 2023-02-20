extends Camera2D

var fixed_toggle_point = Vector2(0,0)

func _process(delta):
	if Input.is_action_just_pressed('map_drag'):
		var ref = get_viewport().get_mouse_position()
		fixed_toggle_point = ref
	if Input.is_action_pressed('map_drag'):
		slide_map_around()

# slides the map around
func slide_map_around():
	var ref = get_viewport().get_mouse_position()
	self.global_position.x -= (ref.x - fixed_toggle_point.x)
	self.global_position.y -= (ref.y - fixed_toggle_point.y)
	fixed_toggle_point = ref

