extends Control


var quests = {} #indexed by quest name

#quests[tracked]
var tracked:String = "Fight the scarecrow"

@export var starting_quest:Quest
@export var inventory:NodePath

func task_string(task):
	var r = "Collect %d/%d %s."%[task.progress,task.target_amount,task.target_item.id]
	return r

func quest_tasks_string(quest):
	var r = ""
	for task in quest.tasks:
		r = r+task_string(task)+"\n"
	return r

func finished(quest):
	for task in quest.tasks:
		if not task.finished:
			return false
	return true

func give_rewards(quest):
	for item in quest.rewards:
		get_node(inventory).add(item)

func update_tracker():
	%quest_tracker.get_node("title").text=tracked
	%quest_tracker.get_node("description").text=quest_tasks_string(quests[tracked])

func finish_task(quest,task):
	task.finished=true
	if(finished(quest)):
		$quest_complete_sfx.play()
		give_rewards(quest)

#update the progress if this item is part of a quest line
func item_picked_up(item):
	for key in quests:
		var quest = quests[key] #oh you...
		for task in quest.tasks:
			if task.type=="collect" and task.target_item.id==item.id:
				task.progress+=item.count
				#print("Collected quest item,",task.progress,"/",task.target_amount);
				if(task.progress>=task.target_amount and not task.finished):
					finish_task(quest,task)
#				if(quest.name==key):
#					$hud/description.text=task_string(task)

func update_tracked(_index):
	if($list.is_anything_selected()):
		var index=$list.get_selected_items()[0]
		tracked = $list.get_item_text(index)
	$description.text=quests[tracked].description
	update_tracker()


func add_quest(quest):
	assert(quest,"tried to add a quest that doesn't exist.")
	if(quests.has(quest.name)):
		return
	quests[quest.name]=quest
	$list.add_item(quest.name)

func _input(_event):
	if Input.is_action_just_pressed("open_questlog"):
		get_parent().toggle_from_child(name)

func _ready():
	if starting_quest:
		add_quest(starting_quest)
		tracked=starting_quest.name
		update_tracker()
