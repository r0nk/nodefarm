extends Button

func _pressed() -> void:
	#tell shop logic to transfer item to player inventory.
	#TODO if player doesn't have space, return
	var inventory = %shop_logic.customer.get_node("inventory")
	inventory.add($slot.item)
	%buy_sfx.play()
	pass
