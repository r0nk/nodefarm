extends Node3D

#this handles the stuff the player holds in their hand

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
