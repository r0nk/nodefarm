@tool
extends Node3D

func shuffle():
	$head/nose.frame=randi_range(0,$head/nose.sprite_frames.get_frame_count("default"))
	$torso.material.albedo_color=["red","green","blue","purple"].pick_random()
	$head/hair.material.albedo_color=["red","green","blue","purple"].pick_random()

@export_tool_button("randomize","Callable") var shuffle_action = shuffle

@export_range(0.0,1.0) var confusion = 0.0

func _process(delta: float) -> void:
	$head/left_brow.rotation.x=confusion
	$head/right_brow.rotation.x=confusion
