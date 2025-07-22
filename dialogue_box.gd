extends Area3D

@export var dialogue:DialogueResource

var balloon

func _ready():
	if dialogue == null:
		$cs.disabled=true

func start_dialogue():
	balloon.start(dialogue,"start")

func interact():
	balloon = load("res://dialogues/balloon/balloon.tscn").instantiate()
	balloon.ready.connect(start_dialogue) # We have to wait for the balloon to finish loading
	Player.add_child(balloon)
	Player.move_locked=true
