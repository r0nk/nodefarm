extends Control

var quests = {} #indexed by quest name
var progress = {}

func add_quest(quest):
	print("adding quest '",quest.name,"' to questlog");
	quests[quest.name]=quest
	$list.add_item(quest.name)

func _progress():
	var keys = quests.keys()
	if(len(keys)<=0):
		return

func _input(_event):
	if Input.is_action_just_pressed("open_questlog"):
		visible=!visible
