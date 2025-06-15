extends TabBar

func _tab_changed(tab_index):
	for child in get_panels():
		if(get_tab_title(tab_index)==child.name):
			child.visible=true
		else:
			child.visible=false

func get_panels():
	return get_children().filter(func(c): return (c is Panel))

func _ready():
	clear_tabs()
	for child in get_panels():
		add_tab(child.name)
		child.visible=false
	if(visible):
		current_tab=1
		get_node(get_tab_title(current_tab)).visible=true
	tab_changed.connect(_tab_changed)
	#if we're testing this menu, dont hide it
	visible=(self == get_tree().current_scene)

func activate():
	get_tree().paused=true
	visible=true

func toggle_from_child(name):
	if(visible and get_node(NodePath(name)).visible):
		visible=false
		get_tree().paused=false
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		return

	for child in get_panels():
		child.visible=false
	get_node(NodePath(name)).visible=true
	visible=true
	get_tree().paused=true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _input(event: InputEvent) -> void:
	if( Input.is_action_just_pressed("escape")):
		visible=false

