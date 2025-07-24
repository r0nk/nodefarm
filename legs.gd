extends Node3D

@export var speed:float = 5.0

@export var target:Node

@onready var navigation_agent:NavigationAgent3D = $pathfind

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

func _process(delta):
	if navigation_agent.is_navigation_finished() or move_locked:
		if $anim.is_playing():
			$anim.play("RESET")
		return

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
#	print("global_pos",global_position);
#	print("npp",navigation_agent.get_next_path_position());

	p.velocity*=speed
	p.move_and_slide()

