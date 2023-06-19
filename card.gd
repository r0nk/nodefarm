extends TextureRect

var default_size = Vector2(250,350)

var in_hand=true
var mouse_hovering=false
var dragging=false

func place():
	in_hand=false

func _process(delta):
	if mouse_hovering and in_hand and Input.is_mouse_button_pressed(1):
		position=get_viewport().get_mouse_position()-(size/2)
		dragging=true
	else:
		if(dragging): #player must have just released card
			for square in get_tree().get_nodes_in_group("card_squares"):
				var dist = position.distance_to(square.position)
				if(dist < 200):
					in_hand=false
					$placement_sfx.play()
					position=square.position
		dragging=false

	if (!dragging and in_hand):
		if position.y < 700:
			position.y+=delta*1000
		if position.y > 700:
			position.y=700


#attack
#draw
#discard

func _on_mouse_entered():
	mouse_hovering=true
	scale=Vector2(1.2,1.2)

func _on_mouse_exited():
	scale=Vector2(1,1)
	if(dragging==false):
		mouse_hovering=false



