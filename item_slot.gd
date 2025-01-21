extends Button

@export var item:Item

func hover_on():
	if not item:
		$tooltip.visible=false
		return
	$tooltip/title.text=item.id
	$tooltip/description.text=item.description
	$tooltip/flavor.text=item.flavor
	$tooltip.visible=true

func hover_off():
	$tooltip.visible=false

func _ready():
	mouse_entered.connect(hover_on)
	mouse_exited.connect(hover_off)

func _process(_delta):
	if not item:
		$count.text=""
		icon=null
		return
	icon=item.texture
	$count.text=str(item.count)

