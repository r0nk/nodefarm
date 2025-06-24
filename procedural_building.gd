extends CSGBox3D

# Based on https://vanwijk.win.tue.nl/stm.pdf
# and https://ar5iv.labs.arxiv.org/html/1211.5842

var s_scene = preload("res://subtraction.tscn")

@export var seed = "random starting string"

@export var wall_size = 0.5

var rng = RandomNumberGenerator.new()

var rooms = []

func r(array):
	return " "+array.pick_random()

func generate_seed():
	return r(["A","The"])+r(["big","ugly","kind","weird","cool","wicked"])+r(["cat","dog","bird","hotdog","banana"])

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

func layout(row):
	pass

func worst_ratio(room):
	ret = []
#	for rect in layout(sizes,x,y,dx,dy):
#		ret.append([rect.dx/rect.dy,rect.dy/rect.dx].max())
	return ret.max()

func squarify(rooms):
	#recursive function, place one room, then return that + squarify_rest
	#if(worst(row

	#return room+squarify(rest)
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
	squarify(rooms)

func _ready():
	seed=generate_seed()
	generate()

#siblings should only intersect if one's a door or window
#doors are centered on the circumference (on the polygon line)
#subtractions should try to snap to walls if possible

#procedural subdivider
