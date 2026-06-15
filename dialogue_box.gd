extends Area3D

@export var dialogue:DialogueResource

var balloon

@export var starting_point = "start"

func _ready():
	if dialogue == null:
		$cs.disabled=true

func start_dialogue():
	balloon.start(dialogue,starting_point)

func dialogue_over(resource):
	if $"../legs":
		$"../legs".move_locked=false
	if $"../head":
		$"../head".rotation*=0

func interact():
	balloon = load("res://dialogues/balloon/balloon.tscn").instantiate()
	balloon.ready.connect(start_dialogue) # We have to wait for the balloon to finish loading
	Player.add_child(balloon)
	Player.move_locked=true
	if $"../legs": $"../legs".move_locked=true
	if $"../head": $"../head".look_at(Player.get_node("camera").global_position)
	DialogueManager.dialogue_ended.connect(dialogue_over)

