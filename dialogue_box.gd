extends Area3D

@export var dialogue:DialogueResource

var balloon

func start_dialogue():
	balloon.start(dialogue,"start")

func interact():
	balloon = load("res://dialogues/balloon/balloon.tscn").instantiate()
	balloon.ready.connect(start_dialogue) # We have to wait for the balloon to finish loading
	var player = get_tree().get_nodes_in_group("player")[0]
	player.add_child(balloon)
	player.move_locked=true

