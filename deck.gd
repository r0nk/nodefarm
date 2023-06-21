extends Node2D

var card = load("res://card.tscn")

func draw():
	return card.instantiate()
