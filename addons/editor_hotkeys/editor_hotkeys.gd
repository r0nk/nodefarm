@tool
extends EditorPlugin

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_M and event.ctrl_pressed:
			print("HOTKEY")
			var player = get_tree().get_nodes_in_group("player")[0]
			EditorInterface.edit_node(player)

func selection_changed():
	pass

func _enter_tree() -> void:
	print("Editor hotkeys entered tree.")
#	EditorInterface.get_selection().selection_changed.connect(selection_changed)

func _exit_tree() -> void:
	# Clean-up of the plugin goes here.
	pass
