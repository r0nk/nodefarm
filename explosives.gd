extends Node3D

func activate():
	%rocks.queue_free()
	%business_man.story_step()
	$model.visible=false
	$sfx.play()
	$particles.emitting=true
