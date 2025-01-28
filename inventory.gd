extends Node3D

signal item_picked_up(item)

func add(thing:Item):
	var slots = get_tree().get_nodes_in_group("slot")
	slots.sort()
	slots = slots.filter(func(s):return not s.is_in_group("equipment_slot"))
	#slots.map(print)
	for slot in slots:
		if not slot.item:
			slot.item=thing
			break
		if(slot.item.id==thing.id and (slot.item.count<slot.item.max_stacks)):
			slot.item.count+=1
			break
	item_picked_up.emit(thing)
