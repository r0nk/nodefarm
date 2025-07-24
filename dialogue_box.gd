extends Area3D

@export var dialogue:DialogueResource

var balloon

func _ready():
	if dialogue == null:
		$cs.disabled=true

func start_dialogue():
	balloon.start(dialogue,"start")

func dialogue_over(resource):
	$"../legs".move_locked=false
	$"../head".rotation*=0

func interact():
	balloon = load("res://dialogues/balloon/balloon.tscn").instantiate()
	balloon.ready.connect(start_dialogue) # We have to wait for the balloon to finish loading
	Player.add_child(balloon)
	Player.move_locked=true
	$"../legs".move_locked=true
	$"../head".look_at(Player.get_node("camera").global_position)
	DialogueManager.dialogue_ended.connect(dialogue_over)

