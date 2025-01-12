extends Resource
class_name Quest

#must be unique
@export var name: String
@export_multiline var description: String
@export var task: QuestTask

func _init(n="",d=""):
	name=n
	description=d
