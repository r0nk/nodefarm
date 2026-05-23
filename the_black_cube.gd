extends CSGBox3D

var default_power=10

func _process(delta):
	rotation.y+=delta

func spawn_gobbies(power):
	for i in range(int(power)):
		$gobby_spawner.spawn()

func death_pulse(power):
	var targets = get_tree().get_nodes_in_group("enemy")
	targets.append(Player)
	for target in targets:
		target.get_node("health").hurt(power)

var spells = [death_pulse,spawn_gobbies]
func wild_magic_surge():
	var spell = spells.pick_random()
	spell.call(default_power)
	$Label3D.text=spell.get_method()
	$HeavyPulse.play()
