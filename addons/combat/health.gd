extends Sprite3D

@export var regen_rate = 1
@export var dodge_chance = 0.0

@export var free_on_death=true

@export var shield=0

signal hit(damage)
signal shield_break(damage)
signal die()

var dmgn = load("res://addons/combat/dmg_number.tscn")

func heal(damage):
	$sv/bar.value+=damage

func hurt(damage):
	if damage<0:
		heal(-damage)
		return
	hit.emit(damage)
	if(shield>0):
		shield-=1
		if(shield<=0):
			shield_break.emit(damage)
			$deshield_sfx.play()
		return
	if(randf()<dodge_chance):
		#dodge_sfx.play()
		return
	$hurt_sfx.play()
	var instance = dmgn.instantiate()
	$sv/bar.value-=damage

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if($sv/bar.value <=0):
		die.emit()
		if(free_on_death):
			get_parent().queue_free()
	$sv/bar.value+=delta*regen_rate
	$sv/follow_bar.max_value=$sv/bar.max_value
	if($sv/follow_bar.value > $sv/bar.value):
		$sv/follow_bar.value-=delta*$sv/bar.max_value
	else:
		$sv/follow_bar.value=$sv/bar.value

