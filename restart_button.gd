extends Button

func _pressed():
	Player.target_scale=Vector3(0.1,0.1,0.1)
	Player.global_position=Vector3(0,0,0)
	get_tree().reload_current_scene()
