extends Node3D

@export var loot_entries:Array[LootEntry]

var item_scene = preload("res://addons/fpsrpg_controller/item.tscn")

func drop():
	for l in loot_entries:
		if(l.probability>randf()):
			continue
		var item = item_scene.instantiate()
		var r = get_tree().get_current_scene()
		item.get_node("cs").disabled=true
		item.resource=l.item
		r.add_child(item)
		item.global_position=global_position
		item.position.x+=randf_range(-2,2)
		item.position.z+=randf_range(-2,2)
		item.get_node("cs").disabled=false
