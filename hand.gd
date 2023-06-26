extends Node2D

func _process(delta):
	var card_count = 0
	var total_cards = get_children().size()
	for card in get_children():
		if(!card.dragging):
			card.position.x=card_count*100
		card_count+=1

