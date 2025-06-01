extends CSGBox3D

var s_scene = preload("res://subtraction.tscn")

@export var seed = "random starting string"

@export var wall_size = 0.5

var rng = RandomNumberGenerator.new()

var rooms = []

func connectivity_graph(rooms):
	var graph = [[0,1],[1,2]]
	return graph

func add_room(to):
	var room = s_scene.instantiate()
	room.size.x=to.size.x-wall_size
	room.size.z=to.size.z-wall_size
	return room

func generate_rooms():
	# [name,size,range]
	var rooms = [
		["living",10,2],
		["bedroom",5,1],
		["bathroom",3,0],
		]
	return rooms

func worst_ratio():
	pass

func squarify(rooms):
	pass

func generate():
	print("generating from seed \"",seed,"\" ");

	rng.seed=(seed.hash())

	#place rooms with squarified treemap
	#place the corridors
	#place windows and doors

	for room in generate_rooms():
		var instance = add_room($".")
		instance.name = room[0]
		instance.size.x=room[1]/2+randf_range(0,room[2]/2)
		instance.size.z=room[1]/2+randf_range(0,room[2]/2)
		rooms.append(instance)
	var graph = connectivity_graph(rooms)

func _ready():
	generate()

#siblings should only intersect if one's a door or window
#doors are centered on the circumference (on the polygon line)
#subtractions should try to snap to walls if possible

#procedural subdivider



