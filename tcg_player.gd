extends Node2D

var health = 20

func _process(_delta):
	$health.text=str(health)

func end_turn():
	for slot in $side.get_children():
		for card in slot.get_children():
			card.end_of_turn()
	if($hand.get_children().size()<10):
		$hand.add_child($deck.draw())
