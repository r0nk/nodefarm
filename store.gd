extends Area3D

@export var items:Array[Item]

func interact():
	#open up the store panel
	var sp = Player.get_node("store_panel")
	var sl = sp.get_node("shop_logic")
	sp.toggle_from_child("Buy")
	sl.customer=Player
	sl.store=$"."

