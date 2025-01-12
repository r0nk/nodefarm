extends Button

@export_file("*.tscn") var scene_path = "res://main3d.tscn"

func _ready():
	pressed.connect(p)

func p():
	get_tree().change_scene_to_file(scene_path)
