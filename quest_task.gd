extends Resource
class_name QuestTask

@export_enum("collect","talk","slay","deliver") var type: String
@export var location:Vector3 = Vector3(0,0,0)
@export var target_amount:float = 1 #How much I am supposed to collect
@export var target_item:Item
@export var progress:float = 0
var finished:bool = false

func _init():
	resource_local_to_scene=true
