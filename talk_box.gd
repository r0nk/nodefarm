extends Area3D

func add_quests():
	var player = get_tree().get_nodes_in_group("player")[0]
	var children = get_parent().get_children()
	for child in children:
		if child.is_in_group("quest"):
			player.get_node("questlog").add_quest(child.r)
			child.visible=false

func interact():
	add_quests()
