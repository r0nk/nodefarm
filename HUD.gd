extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	$inventory.visible=false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("inventory"):
		if $inventory.visible==false:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			$inventory.visible=true
			get_node("../../").move_locked=true
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			$inventory.visible=false
			get_node("../../").move_locked=false
	pass
