extends Area3D

@export var value = 0
@export var stickyness = 0.5

@export var continuous=false

signal clicked(value)

var moved = 0

var locked_in=false

func interact():
	locked_in=true

func click(d):
	clicked.emit(value)
	value+=d
	$sfx.play()
	$sfx.pitch_scale=randf_range(3.95,4.05)

func _input(event):
	if (event is InputEventMouseMotion) and locked_in:
		var x = event.relative.x
		if continuous:
			$handle.rotation.x-=x/360
		moved+=x/360
		if moved > stickyness:
			moved-=stickyness
			if not continuous: $handle.rotation.x-=0.1
			click(1)
		elif moved <-stickyness:
			moved+=stickyness
			if not continuous: $handle.rotation.x+=0.1
			click(-1)

func _process(_delta):
	if !locked_in:
		return
	if !Input.is_action_pressed("interact"):
		locked_in=false
		Player.move_locked=false
		return
	Player.move_locked=true
