extends Node3D

var building_scene = load("res://building.tscn")

var building

func build():
	building.get_node("model").visible=true
	building.get_node("blueprint").visible=false
	building=null
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if building == null:
		building=building_scene.instantiate()
		building.get_node("model").visible=false
		get_node("../../../").add_child(building)
	if $cast.is_colliding():
		building.visible=true
		building.position=$cast.get_collision_point()
		if Input.is_action_just_pressed("fire"):
			build()
	else:
		building.visible=false
