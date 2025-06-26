extends Area3D

func teleport_back(body):
	if body.is_in_group("player"):
		$sfx.play()
		body.position=%player_spawn.position;

func _ready() -> void:
	body_entered.connect(teleport_back)
