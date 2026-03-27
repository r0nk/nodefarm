extends GridMap

func get_random():
	return randi()%mesh_library.get_item_list().size()

func _ready():
	clear()
	for x in 5:
		for z in 5:
			set_cell_item(Vector3(x,0,z+2),get_random())
