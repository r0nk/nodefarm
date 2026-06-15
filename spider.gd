extends CharacterBody3D

@export var s_factor=1.0
@export var interaction_string = "eat"

func interact():
	if Player.target_scale.x+0.1<s_factor:
		return
	Player.target_scale+=Vector3(s_factor,s_factor,s_factor)
	Player.get_node("camera/interact_cast").target_position.z-=s_factor*2
	queue_free()
