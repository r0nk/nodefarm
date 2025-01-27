extends Node3D

func _exiting():
	var p = get_tree().get_nodes_in_group("player")[0]
	p.slow_fall=false

func _ready():
	tree_exiting.connect(_exiting)
	var p = get_tree().get_nodes_in_group("player")[0]
	p.slow_fall=true
