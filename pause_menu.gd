extends Panel

func toggle():
	visible=!visible
	get_tree().paused=visible
	if !visible:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _input(event):
	if Input.is_action_just_pressed("escape"):
		toggle()


