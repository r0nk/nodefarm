extends Control

var tracked:String = "Fight the scarecrow"
var quests = {} #indexed by quest name

func task_string(task):
	return "Collect %d/%d %s."%[task.progress,task.target_amount,task.target_item.id]

#update the progress if this item is part of a quest line
func item_picked_up(item):
	for key in quests:
		var quest = quests[key] #oh you...
		for task in quest.tasks:
			if task.type=="collect" and task.target_item.id==item.id:
				task.progress+=item.count
				#print("Collected quest item,",task.progress,"/",task.target_amount);
				if(task.progress>=task.target_amount):
					task.finished=true
				if(quest.name==key):
					$hud/description.text=task_string(task)


func add_quest(quest):
	quests[quest.name]=quest
	$panel/list.add_item(quest.name)
	if(!$panel/list.is_anything_selected()):
		$panel/description.text=quest.description

func _input(_event):
	if Input.is_action_just_pressed("open_questlog"):
		$panel.visible=!$panel.visible
