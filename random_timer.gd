extends Timer

@export var range = 0.1

var base_wait

func randomize_time():
	wait_time=wait_time+randf_range(-range,range)

func _ready():
	base_wait=wait_time
	randomize_time()
	timeout.connect(randomize_time)
