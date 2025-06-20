extends Node3D

#this handles the scenes the player equips.
#actual item data is stored in the item slot ui element

@export var hotkey:String

var node:Node

func selection_changed(item):
	if(is_instance_valid(node)):
		node.queue_free()
	if not item:
		$sprite.visible=false
	else:
		if not item.equipped_scene:
			$sprite.visible=true
			$sprite.texture=item.texture
		else:
			$sprite.visible=false
			node=item.equipped_scene.instantiate()
			add_child(node)

func _input(event: InputEvent) -> void:
	if(hotkey ==""):
		return
	if(Input.is_action_just_pressed(hotkey)):
		if node and node.has_method("activate"):
			node.activate()

func _ready():
	if(!is_instance_valid(node)):
		selection_changed(null)
