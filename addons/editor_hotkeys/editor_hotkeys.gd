@tool
extends EditorPlugin

func add_collision_shape():
	var cs = CollisionShape3D.new()
	var selected = EditorInterface.get_selection().get_selected_nodes()[0]
	print("adding cs to ",selected.name);
	selected.add_child(cs)
	cs.shape=SphereShape3D.new()
	cs.shape.radius=10
	cs.name="cs"
	cs.owner=get_tree().edited_scene_root


func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_E and event.ctrl_pressed:
			add_collision_shape()
#			EditorInterface.edit_node(Player)

func selection_changed():
	pass

func _enter_tree() -> void:
	print("Editor hotkeys entered tree.")
#	EditorInterface.get_selection().selection_changed.connect(selection_changed)

func _exit_tree() -> void:
	# Clean-up of the plugin goes here.
	pass
