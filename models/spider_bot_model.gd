@tool

extends Node3D
#https://www.youtube.com/watch?v=G_seJ2Yg1GA

var bx = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	bx = $Armature/FLIKTarget.position.x
	pass # Replace with function body.


var counter = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	counter+=delta
	$Armature/FLIKTarget.position.x=bx+sin(counter)
	pass
