extends Node3D

signal rung

func _ready():
	var scale_ratio = scale.x+scale.y+scale.z/3
	$sfx.pitch_scale=1/scale_ratio

func hurted():
	$model/AnimationPlayer.play("impact")
	$sfx.play()
	rung.emit()

