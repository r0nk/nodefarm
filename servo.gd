extends Node2D

export var speed = 20
var target = Vector2(0,1)
func set_direction(direction):
	direction.y*=-1
	target = direction.rotated(PI/2)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	var angle = (target - self.global_position).angle()
	var angle = (target).angle()
	self.global_rotation = lerp_angle(self.global_rotation, angle, delta*speed)
