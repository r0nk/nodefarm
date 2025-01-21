extends Control

func _ready():
	fit()

func fit():
	var winsize = DisplayServer.window_get_size()
	if (global_position.x+size.x) > winsize.x:
		get_parent().position.x-=size.x
	if (global_position.y+size.y) > winsize.y:
		get_parent().position.y-=size.y
