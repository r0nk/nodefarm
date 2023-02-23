extends Node2D


export var path = "res://MyScene.tscn"
export var is_item = false

var output_scene = load(path)

func produce():
	var instance = output_scene.instance()
	get_node("../../").add_child(instance)

func _ready():
	pass # Replace with function body.

