extends Node3D

#chunk based procedural_generator

var chunk_scene=preload("res://chunk.tscn")

var chunk_size = Vector2(200,200)

var scaling_factor=200

#hash accessed like a 2d array, "x,y"
var chunk_map = {}

func _process(delta: float) -> void:
	var p = Player.global_position
	var mp = Vector2(p.x,p.z)/scaling_factor
	var fp = Vector2(round(mp.x),round(mp.y))
#	print(fp)
	var surrounding = [
		Vector2(0,-1)+fp,
		Vector2(0,0)+fp,
		Vector2(0,1)+fp,
		Vector2(1,-1)+fp,
		Vector2(1,0)+fp,
		Vector2(1,1)+fp,
		Vector2(-1,-1)+fp,
		Vector2(-1,0)+fp,
		Vector2(-1,1)+fp,
		]
	for point in surrounding:
		var q = str(point.x) + "," + str(point.y)
		if (not chunk_map.has(q)) or not chunk_map[q]:
			chunk_map[q]=chunk_scene.instantiate()
			add_child(chunk_map[q])
			chunk_map[q].global_position=Vector3(point.x*scaling_factor,-8,point.y*scaling_factor)
