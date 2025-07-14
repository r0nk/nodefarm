extends WorldEnvironment

#in military hours
var time_of_day = 12

#how fast do days progress relative to earth?
@export var day_speed = 0.0

@export var world_radius = 500

@export var boundries = true

var day = 0

func set_boundries():
	$west_boundry.position.z=-world_radius
	$east_boundry.position.z=world_radius
	$south_boundry.position.x=-world_radius
	$north_boundry.position.x=world_radius

func _ready():
	if boundries:
		set_boundries()
	$west_boundry/cs.disabled=not boundries
	$east_boundry/cs.disabled=not boundries
	$south_boundry/cs.disabled=not boundries
	$north_boundry/cs.disabled=not boundries

func _process(delta):
	time_of_day+=(delta*day_speed)/3600.0
	if(day_speed>0):
		rotate_sun()

func rotate_sun():
	$sun.rotation_degrees.x=360*(time_of_day/24.0)
