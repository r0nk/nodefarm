@tool
extends Node3D

@export_range(0.0,1.0) var confusion

func _process(delta: float) -> void:
	$left_brow.rotation.x=confusion
	$right_brow.rotation.x=confusion
