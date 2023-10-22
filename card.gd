extends Node2D

@export var card_resource: Card_Resource

var default_size = Vector2(250,350)

var in_hand=true
var mouse_hovering=false
var dragging=false

func _ready():
	$texture/title.text= card_resource.title
	$texture/description.text= card_resource.description
	$texture/portrait.texture=load("res://images/portraits/"+card_resource.portrait_path+".png")

func place():
	in_hand=false

func end_of_turn():
	attack()

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		var mp = get_viewport().get_mouse_position()
		if mouse_hovering and not dragging and event.pressed:
			dragging = true
		# Stop dragging if the button is released.
		if dragging and not event.pressed and in_hand:
			for square in get_tree().get_nodes_in_group("card_squares"):
				var dist = mp.distance_to(square.global_position)
				if(dist < 200):
					in_hand=false
					$placement_sfx.play()
					reparent(square)
					set_global_position(square.global_position)
			dragging = false
			z_index=0

	if event is InputEventMouseMotion and dragging and in_hand:
		#position=get_viewport().get_mouse_position()+(Vector2(0,1)*$texture.size/2)
		z_index=1
		var mp = get_viewport().get_mouse_position()
		set_global_position(mp)
		for square in get_tree().get_nodes_in_group("card_squares"):
			var dist = mp.distance_to(square.global_position)
			if(dist < 200):
				set_global_position(square.global_position)

func _process(delta):
	if (!dragging and in_hand):#go back to hand location
		if position.y < 0:
			position.y+=delta*1000
		if position.y > 0:
			position.y=0

func attack():
	if(in_hand):
		return
	get_node("../../../../enemy").health -= 1

func discard():
	#deathrattles or whatever
	queue_free()

func draw_card():
	# whenever this card is drawn etc.
	pass

func _on_mouse_entered():
	mouse_hovering=true
	z_index=10
	scale=Vector2(1.2,1.2)

func _on_mouse_exited():
	scale=Vector2(1,1)
	z_index=0
	if(dragging==false):
		mouse_hovering=false



