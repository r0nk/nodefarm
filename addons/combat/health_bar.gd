extends ProgressBar

@onready var player = get_tree().get_root().get_node("main/player")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	value=player.health/5
	pass
