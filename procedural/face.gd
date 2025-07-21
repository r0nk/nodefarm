@tool
extends Node3D

@export var seed = "john smith"

var rng=RandomNumberGenerator.new()
func s_pick_random(array):
	return array[rng.randi()%array.size()]

func shuffle():
	rng.seed=hash(seed)
	if(seed == ""):
		rng.randomize()
	$head/nose.frame=rng.randi_range(0,$head/nose.sprite_frames.get_frame_count("default"))
	$torso.material.albedo_color=s_pick_random(["red","green","blue","purple"])
	$head/hair.material.albedo_color=s_pick_random(["red","green","blue","purple"])

@export_tool_button("randomize","Callable") var shuffle_action = shuffle

@export_range(0.0,1.0) var confusion = 0.0

func _process(delta: float) -> void:
	pass

func _ready():
	rng.seed=hash(seed)
	$head/hair.material = $head/hair.material.duplicate()
	$torso.material = $torso.material.duplicate()
	shuffle()
