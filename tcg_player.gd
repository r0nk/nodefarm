extends Node2D

func end_turn():
	for slot in $side.get_children():
		for card in slot.get_children():
			card.end_of_turn()
	$hand.add_child($deck.draw())
	for i in $hand.get_children():
		print(i)
