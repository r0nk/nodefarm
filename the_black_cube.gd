extends CSGBox3D

var default_power=10

func _process(delta):
	rotation.y+=delta

func reduce_timer():
	$timer.wait_time*=0.5

func double_power():
	default_power*=2.0

func spawn_gobbies(power):
	for i in range(int(power)):
		$gobby_spawner.spawn()

func death_pulse(power):
	var targets = get_tree().get_nodes_in_group("enemy")
	targets.append(Player)
	for target in targets:
		target.get_node("health").hurt(power)

func heal_pulse(power):
	var targets = get_tree().get_nodes_in_group("enemy")
	targets.append(Player)
	for target in targets:
		target.get_node("health").hurt(-power*2)

func profit(power):
	Player.get_node("inventory").cash+=power

func wild_magic_surge():
	var spells = [death_pulse,heal_pulse,spawn_gobbies,profit]
	var spell = spells.pick_random()
	spell.call(default_power)
	$Label3D.text=spell.get_method()
	$HeavyPulse.play()
