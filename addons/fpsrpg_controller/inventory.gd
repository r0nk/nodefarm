extends Node3D

signal item_picked_up(item)

@export var cash:float = 20.0

func get_slots():
	var c = get_node("../game_menu/Inventory").get_children()
	var ret = c.filter(func(n):
		return not n.is_in_group("equipment_slot") and n.is_in_group("slot"))
	return ret

func try_equip_to(thing,slots):
	var equipment_slots = slots.filter(func(n):
		return  n.is_in_group("equipment_slot") and n.is_in_group("slot"))
	equipment_slots.sort()
	for e in equipment_slots:
		if not e.item and e.type == thing.type:
			e.item=thing
			return true
	return false

func auto_equip(thing):
	var ret = false
	ret = ret or try_equip_to(thing,get_node("../game_menu/Inventory").get_children())
	ret = ret or try_equip_to(thing,$"view/hotbar".get_children())
	return ret

func add(thing:Item):
	if not thing:
		return
	thing = thing.duplicate()
	if (thing.id=="coin"):
		cash+=thing.price
		return
	if auto_equip(thing):
		return
	var slots = get_slots()
	slots.sort()
	slots.reverse()
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

func contains(item):
	if not item:
		return false
	var slots = get_slots()
	for slot in slots:
		if not slot.item:
			continue
		if slot.item.id==item.id and slot.item.count>=slot.item.count:
			return true
	return false

func remove(item):
	if not item:
		return false
	var slots = get_slots()
	for slot in slots:
		if not slot.item:
			continue
		if slot.item.id==item.id and slot.item.count>=slot.item.count:
			slot.item.count-=item.count
			assert(slot.item.count>=0,"We shouldn't be able to remove more then exists")
			if(slot.item.count ==0):
				slot.item = null
			return true
	return false


func items_matching_type(type):
	var slots = get_slots()
	var matching_slots = slots.filter(func(s): return s.item and s.item.type==type)
	var ret = matching_slots.map(func(s): return s.item)
	return ret
