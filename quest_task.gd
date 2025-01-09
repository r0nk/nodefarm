extends Resource
class_name QuestTask

@export var text: String
@export var description: String
@export var sub_tasks: QuestTask
@export_enum("collect","talk","slay","deliver","escort") var type: String
@export var location:Vector3

func _init(t="",d=""):
	text=t
	description=d
