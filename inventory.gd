extends Node3D

@export var slots = {"one":null,"two":null,"three":null}

@export var max_slots = 9

@export var filled_slots = 0

func add(thing):
	for key in slots.keys():
		if not slots[key]:
			slots[key]=thing
			break
		if(slots[key].id==thing.id and (slots[key].count<slots[key].max_stacks)):
			slots[key].count+=1
			break

func update_view():
	if not $view.visible:
		return
	for s in $view/hotbar.get_children():
		if(s.is_in_group("slot")):
			s.item=slots[s.name]

func _process(delta):
	update_view()

