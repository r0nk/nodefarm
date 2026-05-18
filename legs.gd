extends Node3D

@export var speed:float = 5.0

@export var target:Node:
	set(v):
		target=v

@onready var navigation_agent:NavigationAgent3D = $pathfind

@export var debug = false

var move_locked=false

func _ready():
	navigation_agent.path_desired_distance=0.5
	navigation_agent.target_desired_distance=0.5

	actor_setup.call_deferred()

func actor_setup():
	await get_tree().physics_frame
	if(target):
		navigation_agent.set_target_position(target.global_position)

func head_to(target_node):
	target=target_node
	navigation_agent.set_target_position(target.global_position)

func tick():
	if target:
		head_to(target)

func _process(delta):
	if navigation_agent.is_navigation_finished() or move_locked:
		if $anim.is_playing():
			$anim.play("RESET")
		return

	if debug: print("navi:",navigation_agent.is_target_reachable())
	if ! $anim.is_playing():
		$anim.play("walk")
	var p = get_parent()
	p.look_at(navigation_agent.get_next_path_position())
	p.rotation_degrees.x=0

	if ! p.is_on_floor():
		p.velocity.y=-9.8
	else:
		p.velocity.y=0

	p.velocity = global_position.direction_to(navigation_agent.get_next_path_position())
	if debug:
		print("global_pos: ",global_position);
		print("npp: ",navigation_agent.get_next_path_position());
		print("global_position: ",global_position)
		print("p.velocity: ",p.velocity);
		print("p.is_on_floor: ",p.is_on_floor());

	p.velocity*=speed
	p.move_and_slide()

