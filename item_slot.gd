extends Button

@export var item:Item

var origin
var dragging=false
var hovering=false

signal item_changed(item)

func hover_on():
	hovering=true
	if not item or dragging:
		$tooltip.visible=false
		return
	$tooltip/title.text=item.id
	$tooltip/description.text=item.description
	$tooltip/flavor.text=item.flavor
	$tooltip.visible=true

func hover_off():
	hovering=false
	$tooltip.visible=false

func start_drag():
	dragging=true
	flat=dragging

func stop_drag():
	dragging=false
	flat=dragging
	position=origin
	var m = get_global_mouse_position()
	var slots = get_tree().get_nodes_in_group("slot")
	slots = slots.filter(func(s):return s.hovering)
	if !slots[0]:
		return
	var buf = item
	item=slots[0].item
	slots[0].item=buf
	slots[0].item_changed.emit(slots[0].item)
	item_changed.emit(item)

func _ready():
	origin=position
	mouse_entered.connect(hover_on)
	mouse_exited.connect(hover_off)

func _process(_delta):
	if(dragging):
		global_position=get_global_mouse_position()
	if not item:
		$count.text=""
		icon=null
		return
	icon=item.texture
	$count.text=str(item.count)

