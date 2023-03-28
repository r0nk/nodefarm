extends Node

@export var p = 0.5

signal activation

func trigger():
	if randf()<p:
		emit_signal("activation")

