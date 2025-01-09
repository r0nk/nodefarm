extends CharacterBody3D

var input_direction = Vector3()
var accel = Vector3(0,0,0)
var gravity_vector = Vector3(0,-98,0)
var health = 100
#probably a better way of doing this but yolo lmao
var is_player = true
var dead = false
var move_locked = false

@export var speed = 5

var shift_timer=0

var jumps=0
@export var extra_jumps=0
@export var jump_force=200
var power=0

var weapon_array = [[0,1]]

var camera_speed=0.2

signal player_killed

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$camera/HUD/crosshair.position = get_viewport().size/2
	$camera/HUD/sights.position = get_viewport().size/2

func _input(event):
	if (event is InputEventMouseMotion) and not move_locked:
		$camera.rotation_degrees.x=clamp($camera.rotation_degrees.x-event.relative.y*camera_speed,-90,90)
		$camera.rotation_degrees.y-=event.relative.x*camera_speed

func get_aim():
	return -$camera.transform.basis.z

func process_interactibles():
	$camera/HUD/undercross.text=""
	if $camera/interact_cast.is_colliding():
		var body = $camera/interact_cast.get_collider()
		if body.is_in_group("interactibles"):
			$camera/HUD/undercross.text="Press [T] to interact"
			if Input.is_action_just_pressed("interact"):
				$camera/interact_cast/sfx.play()
				body.interact()

func process_input(delta):
	input_direction = Vector3()
	if(move_locked):
		return
	process_interactibles()

	var forward=Vector3(0,0,-1)

	if Input.is_action_just_pressed("escape"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

	if Input.is_action_pressed("up"):
		input_direction+=forward
	if Input.is_action_pressed("down"):
		input_direction+=-forward
	if Input.is_action_pressed("left"):
		input_direction+=forward.rotated(-gravity_vector.normalized(),(3.14/2))
	if Input.is_action_pressed("right"):
		input_direction+=-forward.rotated(-gravity_vector.normalized(),(3.14/2))

	if is_on_floor():
		jumps=extra_jumps
	if jumps>0 and Input.is_action_just_pressed("jump"):
		jumps-=1
#		if not is_on_floor():
#			$jump_sfx.play()
		accel=Vector3(0,0,0)
		velocity-=gravity_vector.normalized()*jump_force
	input_direction = input_direction.normalized().rotated(-gravity_vector.normalized(),$camera.rotation.y)

func dialogic_event_handler(e):
	if e == "unlock_player":
		move_locked=false

#http://kidscancode.org/godot_recipes/3d/3d_align_surface/
#I'm a kid okay
func align_with_y(xform,new_y):
	xform.basis.y = new_y
	xform.basis.x = -xform.basis.z.cross(new_y)
	xform.basis = xform.basis.orthonormalized()
	return xform

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if dead:
		return

	process_input(delta)
	accel += gravity_vector*delta*7
	velocity += (speed*input_direction)+(accel*delta)
	set_velocity(velocity)
	set_up_direction(-gravity_vector.normalized())
	move_and_slide()
#	velocity

	global_transform=global_transform.interpolate_with(align_with_y(global_transform,-gravity_vector.normalized()),0.15)

	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)

	if is_on_floor():
#		accel=-get_floor_normal()*10
		accel*=1-delta
		velocity*=1-(delta*10)
	else:
		velocity*=1-(delta*8)
