extends Node3D

func _process(delta: float) -> void:
	if( not $AnimationPlayer.is_playing()):
		$AnimationPlayer.play("idle")

