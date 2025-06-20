extends WorldEnvironment

#in military hours
var time_of_day = 12

#how fast do days progress relative to earth?
@export var day_speed = 200.0

@export var world_radius = 50

var day = 0

func set_boundries():
	$west_boundry.position.z=-world_radius
	$east_boundry.position.z=world_radius
	$south_boundry.position.x=-world_radius
	$north_boundry.position.x=world_radius

func _ready():
	set_boundries()

func _process(delta):
	time_of_day+=(delta*day_speed)/3600.0
	if(day_speed>0):
		rotate_sun()

func rotate_sun():
	$sun.rotation_degrees.x=360*(time_of_day/24.0)
