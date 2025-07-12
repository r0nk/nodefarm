@tool
extends EditorPlugin

var dock

func add_collision_shape():
	var cs = CollisionShape3D.new()
	var selected = EditorInterface.get_selection().get_selected_nodes()[0]
	print("adding cs to ",selected.name);
	selected.add_child(cs)
	cs.shape=SphereShape3D.new()
	cs.shape.radius=10
	cs.name="cs"
	cs.owner=get_tree().edited_scene_root

func search_children(node,lambda):
	if lambda.call(node):
		return node.get_path()
	for child in node.get_children():
		var results = search_children(child,lambda)
		if results != null:
			return results
	return null

func search_children_for_placeholder(node,string):
#	print(node.name)
#	if 'text' in node:
#		print(node.text)
	if 'placeholder_text' in node:
		if node.placeholder_text.begins_with(string):
			return node.get_path()
	for child in node.get_children():
		var results = search_children_for_placeholder(child,string)
		if results != null:
			return results
	return null

#TODO there's probably a better way to do this buffering
var node_filter_box_path = null
func get_node_filter_box():
	var fb = null
	if node_filter_box_path and has_node(node_filter_box_path):
		fb = get_node(node_filter_box_path)
	if fb == null:
		node_filter_box_path = find_in_interface("Filter:")
		if node_filter_box_path and has_node(node_filter_box_path):
			fb = get_node(node_filter_box_path)
	return fb


#helper function to search interface for text, default text, etc
#extremely expensive, only meant to be used in addon dev
func find_in_interface(string):
	for child in (EditorInterface.get_base_control().get_children()):
		var r = search_children_for_placeholder(child,string)
		if r:
			return r
	return null

func fuzzy_pick_node():
	get_node_filter_box().grab_focus()

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_E and event.ctrl_pressed:
			add_collision_shape()
#			EditorInterface.edit_node(Player)
		if event.keycode == KEY_J and event.ctrl_pressed:
			fuzzy_pick_node()
			get_viewport().set_input_as_handled()


# this code is very gross.
func jump_to_first_available_node(search):
	var nfb =get_node_filter_box()
	var esr = get_tree().edited_scene_root

	var tree_path = search_children(nfb.get_node("../../"),func (n):
		if 'get_root' in n:
			return true
		return false
		)
	var tree = get_node(tree_path)
	var path = ""
	var treeitem = tree.get_root().get_next_visible()
	nfb.clear() #has to be here
	while treeitem != null:
		path = treeitem.get_text(0) +"/"+path
		treeitem = treeitem.get_parent()
	var n = get_tree().edited_scene_root.get_parent().get_node(path)
	EditorInterface.edit_node(n)


func node_filter_to_select():
	var nfb = get_node_filter_box()
	nfb.text_submitted.connect(jump_to_first_available_node)

func selection_changed():
	pass

func _enter_tree() -> void:
	print("Editor hotkeys entered tree.")
	dock = preload("res://addons/editor_hotkeys/fuzzy_searcher.tscn").instantiate()
	add_control_to_dock(DOCK_SLOT_LEFT_BR,dock)
	node_filter_to_select()
#	EditorInterface.get_selection().selection_changed.connect(selection_changed)

func _exit_tree() -> void:
	# Clean-up of the plugin goes here.
	remove_control_from_docks(dock)
	dock.free()
	pass
