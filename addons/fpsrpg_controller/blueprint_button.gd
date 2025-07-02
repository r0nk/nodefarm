extends Button

@export var blueprint:Blueprint

func update_slots():
	$"inputs/slot1".item=blueprint.input1
	$"inputs/slot2".item=blueprint.input2
	$"inputs/slot3".item=blueprint.input3
	$"inputs/slot4".item=blueprint.input4
	$output.item=blueprint.output

func _process(delta):
	update_slots()

func _pressed() -> void:
	#FIXME this is big stupid, blueprints should just have arrays of inputs and outputs
	var inventory =  Player.get_node("inventory")
	var inputs = $inputs.get_children()
	var missing_inputs = inputs.filter(func(i):
		if not i.item:
			return false

		return not inventory.contains(i.item)
		)
	if missing_inputs.size()>0:
		#TODO sound effect for missing outpu
		for i in missing_inputs:
			print ("i.tem:",i.item)
		return
	inventory.remove(blueprint.input1)
	inventory.remove(blueprint.input2)
	inventory.remove(blueprint.input3)
	inventory.remove(blueprint.input4)
	inventory.add(blueprint.output)
