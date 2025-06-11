extends Button

var activated=false

@export var prerequisites:Array[NodePath]

func clear_lines():
	for child in get_children():
		if child is Line2D:
			child.queue_free()

func get_button_midpoint(button):
	return button.global_position+(button.size/2)

func update_prerequisites():
	clear_lines()
	disabled=false
	for prereq in prerequisites:
		var pre_node=get_node(prereq)
		var line = Line2D.new()
		line.global_position=-global_position
		line.add_point(get_button_midpoint($"."))
		line.add_point(get_button_midpoint(pre_node))
		line.default_color="#999999"
		if pre_node.activated:
			line.default_color="#FFFFFF"
		add_child(line)
		line.show_behind_parent=true

		if not pre_node.activated:
			disabled=true

func perk_pressed():
	activated=true
	for perk in get_tree().get_nodes_in_group("perk"):
		perk.update_prerequisites()

func _ready():
	update_prerequisites()
	pressed.connect(perk_pressed)

