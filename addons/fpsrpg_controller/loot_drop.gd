extends Node3D

@export var loot_entries:Array[LootEntry]

var item_scene = preload("res://addons/fpsrpg_controller/item.tscn")

func drop():
	for l in loot_entries:
		if(l.probability>randf()):
			continue
		var item = item_scene.instantiate()
		var r = get_tree().root.get_child(0)
		item.resource=l.item
		item.global_position=global_position
		item.position.x+=randf_range(-2,2)
		item.position.z+=randf_range(-2,2)
		r.add_child(item)

func _ready():
	#get_parent().tree_exiting.connect(drop)
	pass
