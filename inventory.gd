extends Node

var slots = []

@export var max_slots = 9

func add(thing):
	if(slots.size>max_slots):
		print("cannot add over max slots")
		return
	slots.append(thing)
