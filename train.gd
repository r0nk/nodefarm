extends PathFollow3D

var speed = 10

func _process(delta: float) -> void:
	progress+=delta*speed
