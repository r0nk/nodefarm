extends Panel

@export var selected:Node

signal selection_changed(item)

func check_switch(slot):
	if Input.is_action_just_pressed(slot):
		selected=get_node(slot)
		selection_changed.emit(selected.item)

func _process(_delta):
	$select_box.position=selected.position-Vector2(2,-64)
	check_switch("one")
	check_switch("two")
	check_switch("three")
