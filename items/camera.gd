extends Node3D

func _process(_delta):
	if Input.is_action_just_pressed("fire"):
		take_picture()

func take_picture():
	var player = get_tree().get_nodes_in_group("player")[0]
	var screenshot = ImageTexture.create_from_image(get_viewport().get_texture().get_image())
#	player.get_node("picture").texture=screenshot
	var item = Item.new()
	item.texture=screenshot
	item.id="screenshot"
	item.type="junk"
	item.description="taken on "+str(Time.get_time_dict_from_system())
	item.max_stacks=1
	player.get_node("inventory").add(item)
	#crea
