extends Button

@export var item:Item

var origin
var dragging=false
var hovering=false

@export var type:StringName = ""

signal item_changed(item)

func hover_on():
	hovering=true
	if not item or dragging:
		$tooltip.visible=false
		return
	$tooltip/title.text=item.id
	$tooltip/description.text=item.description
	$tooltip/flavor.text=item.flavor
	$tooltip/type.text=item.type
	$tooltip.visible=true

func hover_off():
	hovering=false
	$tooltip.visible=false

func start_drag():
	dragging=true

func swap(slot):
	if slot.type != "" and slot.type != item.type:
		print("incorrect slot type: ",slot.type," , ",item.type);
		return
	var buf = item
	item=slot.item
	slot.item=buf
	slot.item_changed.emit(slot.item)
	item_changed.emit(item)

func stop_drag():
	dragging=false
	$texture.position=origin
	var m = get_global_mouse_position()
	var slots = get_tree().get_nodes_in_group("slot")
	slots = slots.filter(func(s):return s.hovering)
	if len(slots)<=0 or not item:
		return
	swap(slots[0])

func _ready():
	origin=$texture.position
	mouse_entered.connect(hover_on)
	mouse_exited.connect(hover_off)

func _process(_delta):
	if(dragging):
		$texture.global_position=get_global_mouse_position()
	if not item:
		$count.text=""
		$texture.texture=null
		return
	$texture.texture=item.texture
	$count.text=str(item.count)

