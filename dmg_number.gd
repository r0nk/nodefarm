extends Label3D

# Called when the node enters the scene tree for the first time.
func _ready():
	global_scale(Vector3(1,1,1))

var timer=1

var fade_cutoff=0.7

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timer-=delta
	position.y+=delta*20
	if(timer<fade_cutoff):
		modulate.a=timer*(1/fade_cutoff)
		outline_modulate.a=timer*(1/fade_cutoff)
	if(timer<0):
		queue_free()
