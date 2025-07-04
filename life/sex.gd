extends Area3D

@export var mutations: Array[String]

func reproduce():
	var target=get_parent().get_scene_file_path()
	if( mutations.size() >= 1 and randf()<0.1):
		target = mutations.pick_random()
	var scene = load(target)
	var i = scene.instantiate()
	$"../../".add_child(i)

func _process(delta: float) -> void:
	if randf()<0.0001:
		reproduce()
