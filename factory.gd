extends Node2D

@export var path = "res://MyScene.tscn"
@export var is_item = false
@export var radius = 0

var output_scene = load(path)

func produce():
        var instance = output_scene.instantiate()
        instance.position = global_position
        instance.position += Vector2(randf_range(-radius,radius),randf_range(-radius,radius))
        get_parent().add_child(instance)



