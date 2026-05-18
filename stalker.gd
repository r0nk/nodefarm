extends Marker3D

var inital_position

func _ready():
	inital_position=position

func _process(delta):
	var player = get_tree().get_nodes_in_group("player")[0]
	if $"../vosn".is_on_screen():
		$"../drag_sfx".stop()
		position=inital_position
	else:
		if ! $"../drag_sfx".playing:
			$"../drag_sfx".play()
		global_position=player.global_position
