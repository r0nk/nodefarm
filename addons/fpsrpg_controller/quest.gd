extends Node3D

@export var r: Quest

func _ready():
	$title.text=r.name
