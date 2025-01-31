extends Node3D

func _exiting():
	var p = get_tree().get_nodes_in_group("player")[0]
	p.slow_fall=false
	print("wizard hat exiting");


func _ready():
	tree_exiting.connect(_exiting)
	print("wizard hat entering");
	var p = get_tree().get_nodes_in_group("player")[0]
	p.slow_fall=true
