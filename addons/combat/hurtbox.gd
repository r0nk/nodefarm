extends Area3D

@export var multiplier = 1.0

var dmgn = load("res://addons/combat/dmg_number.tscn")

signal hurted

func hurt(damage):
	var instance = dmgn.instantiate()
	instance.text=str(damage*multiplier)
	if(multiplier>1):
		instance.modulate="#FFFF00"
	get_parent().add_child(instance)
	instance.global_position=global_position+Vector3(randf(),randf(),randf())
	hurted.emit()
	$flash_box.visible=true
	$flash_box/Timer.start()

func _on_timer_timeout():
	$flash_box.visible=false
