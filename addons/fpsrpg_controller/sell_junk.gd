extends Button

func _pressed() -> void:
	var player = get_tree().get_nodes_in_group("player")[0]
	var inventory = player.get_node("inventory")
	var to_sell = inventory.items_matching_type("junk")
	for item in to_sell:
		inventory.cash+=item.price
		inventory.remove(item)
