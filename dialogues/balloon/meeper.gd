extends AudioStreamPlayer

func get_mouth():
	var speaker_name = get_parent().dialogue_line.character
	for m in get_tree().get_nodes_in_group("lip_sync_mouth"):
		if m.dialogue_name.to_lower()==speaker_name:
			return m
	return null

func pitchmod():
	var m = get_mouth()
	var base = m.pitch_mod
	var radius=0.1
	pitch_scale=randf_range(base-radius,base+radius)

func volumemod(letter):
	if letter != letter.to_lower():
		volume_db=3
	else:
		volume_db=-10

func lipsync(letter):
	get_mouth().say(letter)

func speak(letter,index,speed):
	if letter ==" ":
		return
	volumemod(letter)
	pitchmod()
	lipsync(letter)
	if playing:
		stop()
	play()
