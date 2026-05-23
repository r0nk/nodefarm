extends CharacterBody3D

var attack_ready=false

func prime_attack():
	attack_ready=true

func _process(delta):
	$legs.target=Player
	var dist_to_player=global_position.distance_to(Player.global_position)
	if attack_ready and dist_to_player < 5:
		Player.get_node("health").hurt(5)
		attack_ready=false

func _ready():
	$timer.timeout.connect(prime_attack)
