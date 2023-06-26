extends Node2D

var health=20

func _process(_delta):
	$health.text="health:"+str(health)

func end_turn():
	attack()

func attack():
	var possible_targets=$"../tcg_player/side".get_children()
	var target = possible_targets[randi()%(possible_targets.size())]
	if target.get_children().size()==0:#attack player instead
		$"../tcg_player".health-=3
	else:
		target.get_children()[0].queue_free()


	for slot in $"../tcg_player/side".get_children():
		for card in slot.get_children():
			card.end_of_turn()



