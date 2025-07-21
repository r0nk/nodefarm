extends Panel

@export var selected:Node

signal selection_changed(item)

func check_switch(slot):
	if Input.is_action_just_pressed(slot):
		selected=get_node(slot)
		selection_changed.emit(selected.item)

func _process(_delta):
	$select_box.position=selected.position-Vector2(2,-64)
	for hotkey in ["one","two","three","four","five"]:
		check_switch(hotkey)
