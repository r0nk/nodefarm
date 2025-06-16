extends Button

func _pressed() -> void:
	#tell shop logic to transfer item to player inventory.
	var inventory = %shop_logic.customer.get_node("inventory")
	if inventory.cash<$slot.item.price:
		return
	#TODO if player doesn't have space, return
	inventory.cash-=$slot.item.price
	inventory.add($slot.item)
	%buy_sfx.play()
	pass
