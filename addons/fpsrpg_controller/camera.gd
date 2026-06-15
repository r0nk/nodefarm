extends Camera3D

func _process(delta):
	if not is_current():
		get_parent().move_locked=true
		$HUD/crosshair.visible=false

