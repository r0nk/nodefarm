extends Node

#for a 'wasd' style control scheme, specify the direction with.

signal change(direction)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var direction = Vector2(0,0)
	if Input.is_action_pressed('up'):
		direction.y=1
	if Input.is_action_pressed('down'):
		direction.y=-1
	if Input.is_action_pressed('left'):
		direction.x=-1
	if Input.is_action_pressed('right'):
		direction.x=1
	emit_signal("change",direction)
