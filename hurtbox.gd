extends Area3D

func hurt(damage):
	$damage_number.text=str(damage)
	get_node("../AnimationPlayer").stop()
	get_node("../AnimationPlayer").play("impact")

