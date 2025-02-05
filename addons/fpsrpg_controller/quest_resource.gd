extends Resource
class_name Quest

@export var name: String #must be unique
@export_multiline var description: String
@export var tasks:Array[QuestTask]
@export var rewards:Array[Item]

func _init(n="",d=""):
	name=n
	description=d
