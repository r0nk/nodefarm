extends Control

var tracked:String = "Fight the scarecrow"
var quests = {} #indexed by quest name


@export var starting_quest:Quest
@export var inventory:NodePath

func task_string(task):
	return "Collect %d/%d %s."%[task.progress,task.target_amount,task.target_item.id]

func finished(quest):
	for task in quest.tasks:
		if not task.finished:
			return false
	return true

func give_rewards(quest):
	for item in quest.rewards:
		get_node(inventory).add(item)


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

func add_quest(quest):
	assert(quest,"tried to add a quest that doesn't exist.")
	if(quests.has(quest.name)):
		return
	quests[quest.name]=quest
	for task in quest.tasks:
		print(task.target_item.id)
	$list.add_item(quest.name)
	if(!$list.is_anything_selected()):
		pass
#		$hud/description.text=task_string(quest.tasks[0])

func _input(_event):
	if Input.is_action_just_pressed("open_questlog"):
		get_parent().toggle_from_child(name)

func _ready():
	if starting_quest:
		add_quest(starting_quest)
