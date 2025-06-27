@tool
extends Node3D

func shuffle():
	print("shuffling face.");

	$nose.frame=randi_range(0,$nose.sprite_frames.get_frame_count("default"))

@export_tool_button("shuffle face","Callable") var shuffle_action = shuffle

@export_range(0.0,1.0) var confusion

func _process(delta: float) -> void:
	$left_brow.rotation.x=confusion
	$right_brow.rotation.x=confusion
