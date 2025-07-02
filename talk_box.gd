extends Area3D

func add_quests():
	var children = get_parent().get_children()
	for child in children:
		if child.is_in_group("quest"):
			Player.get_node("game_menu/Quests").add_quest(child.r)
			child.visible=false

func interact():
	add_quests()
