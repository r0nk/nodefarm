extends AnimatedSprite3D

func unblink():
	visible=true

func blink():
	visible=false
	$"../blink_duration".start()

