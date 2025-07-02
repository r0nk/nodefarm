extends Button

func _pressed() -> void:
	var inventory = Player.get_node("inventory")
	var to_sell = inventory.items_matching_type("junk")
	for item in to_sell:
		inventory.cash+=item.price
		inventory.remove(item)
