extends Button

@export var item:Resource

func _process(_delta):
	if not item:
		$count.text=""
		icon=null
		return
	icon=item.texture
	$count.text=str(item.count)

