@tool
extends MeshInstance3D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotation.y+=delta
	pass
