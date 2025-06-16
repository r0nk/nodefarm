extends Node3D

signal item_picked_up(item)

@export var cash:float = 20.0

func get_slots():
	var c = get_node("../game_menu/Inventory").get_children()
	var ret = c.filter(func(n):return not n.is_in_group("equipment_slot"))
	return ret

func add(thing:Item):
	thing = thing.duplicate()
	if (thing.id=="coin"):
		cash+=thing.price
		return
	var slots = get_slots()
	slots.sort()
	slots.reverse()
	slots = slots.filter(func(s):return not s.is_in_group("equipment_slot"))
	#slots.map(print)
	for slot in slots:
		if not slot.item:
			continue
		if(slot.item.id==thing.id and (slot.item.count<slot.item.max_stacks)):
			slot.item.count+=1
			item_picked_up.emit(thing)
			return
	for slot in slots:
		if not slot.item:
			slot.item=thing
			item_picked_up.emit(thing)
			return
