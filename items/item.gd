extends Resource
class_name Item

@export var texture: Texture2D
@export var id:StringName
@export_multiline var description:String
@export var flavor:String #Some spicy lore for the tooltip
@export var max_stacks: int = 100
@export var count: int = 1
@export var equipped_scene: PackedScene

func _init():
	resource_local_to_scene=true

