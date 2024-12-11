extends Node3D

func _ready():
	$ui.visible=false

func interact():
	$ui.visible=!$ui.visible
