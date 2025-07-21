extends Node3D

func activate():
	var s = Player.get_node("stomach")
	s.hunger-=5
	if(s.hunger<=0):
		s.hunger=0
	Player.get_node("inventory").spend_active()
	$nom_sfx.play()
