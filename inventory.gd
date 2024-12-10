extends Node3D

@export var slots = {"one":null,"two":null,"three":null}

@export var max_slots = 9

@export var filled_slots = 0

func add(thing):
	slots["one"].count+=1

func update_view():
	if not $view.visible:
		return
	$view/hotbar/one.icon=slots["one"].texture
	$view/hotbar/one/count.text=str(slots["one"].count)

func _process(delta):
	update_view()

