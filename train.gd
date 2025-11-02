extends PathFollow3D

var speed = 30

func _physics_process(delta: float) -> void:
	progress+=delta*speed
