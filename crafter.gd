extends Area3D

@export var blueprints:Array[Blueprint]

func interact():
	#open up the store panel
	var sp = Player.get_node("crafting_menu")
	sp.toggle_from_child("Crafting")
