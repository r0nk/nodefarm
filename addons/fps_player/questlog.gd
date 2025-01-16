extends Control

var tracked:String = "Fight the scarecrow"
var quests = {} #indexed by quest name

func task_string(task):
	return "Collect %d/%d %s."%[task.progress,task.target_amount,task.target_item.id]

func finished(quest):
	for task in quest.tasks:
		if not task.finished:
			return false
	return true

#update the progress if this item is part of a quest line
func item_picked_up(item):
	for key in quests:
		var quest = quests[key] #oh you...
		for task in quest.tasks:
			if task.type=="collect" and task.target_item.id==item.id:
				task.progress+=item.count
				#print("Collected quest item,",task.progress,"/",task.target_amount);
				if(task.progress>=task.target_amount and not task.finished):
					task.finished=true
					if(finished(quest)):
						$quest_complete_sfx.play()
				if(quest.name==key):
					$hud/description.text=task_string(task)

func add_quest(quest):
	if(quests.has(quest.name)):
		return
	quests[quest.name]=quest
	for task in quest.tasks:
		print(task.target_item.id)
	$panel/list.add_item(quest.name)
	if(!$panel/list.is_anything_selected()):
		$hud/description.text=task_string(quest.tasks[0])

func _input(_event):
	if Input.is_action_just_pressed("open_questlog"):
		$panel.visible=!$panel.visible
