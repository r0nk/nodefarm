extends AudioStreamPlayer

func pitchmod():
	var speaker_name = get_parent().dialogue_line.character
	var base = 1.0
	var radius=0.1
	match speaker_name:
		"Ember":base=1.5
		"Pops":base=1
		"Lucy":base=0.8
	pitch_scale=randf_range(base-radius,base+radius)

func volumemod(letter):
	if letter != letter.to_lower():
		volume_db=3
	else:
		volume_db=-10

func lipsync(letter):
	var speaker_name = get_parent().dialogue_line.character.to_lower()
	for m in get_tree().get_nodes_in_group("lip_sync_mouth"):
		if m.name.to_lower()==speaker_name:
			m.say(letter)

func speak(letter,index,speed):
	if letter ==" ":
		return
	volumemod(letter)
	pitchmod()
	lipsync(letter)
	if playing:
		stop()
	play()
