extends AnimatedSprite3D

@export var pitch_mod = 1.0

@export var dialogue_name:StringName

func reset():
	say(".")

func say(letter):
	match letter:
		"a","h","k": frame=1
		"o": frame=2
		"e","i","d","x": frame=3
		"w","r","y": frame=4
		"t","s","c","z": frame=5
		"l","n": frame=6
		"u","q","g","j": frame=7
		"m","b","p": frame=8
		"f","v": frame=9
		_: frame=0
	$reset_timer.stop()
	$reset_timer.start()
