extends Node3D

var tree_scene = preload("res://life/plants/tree.tscn")

func _process(delta: float) -> void:
	var d = global_position.distance_to(Player.global_position)
	visible= d<300
	if d > 600:
		queue_free()

func _ready():
	for i in range(randi()%100):
		var t = tree_scene.instantiate()
		add_child(t)
		t.position.x+=randf_range(-200,200)
		t.rotation.y=randf_range(-3.14,3.14)
		t.position.z+=randf_range(-200,200)
