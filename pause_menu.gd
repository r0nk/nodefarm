extends Panel

func active_submenu():
	for c in get_children():
		if(c.is_in_group("submenu") and c.visible):
			return c
	return null

func toggle():
	var s = active_submenu()
	if s:
		s.visible=false
		return
	visible=!visible
	get_tree().paused=visible
	if !visible:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _input(event):
	if Input.is_action_just_pressed("escape"):
		toggle()
