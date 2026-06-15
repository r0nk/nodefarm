extends CharacterBody3D

func story_step():
	global_position=$secondary_position.global_position
	$dialogue_box.dialogue=load("res://dialogues/cotw_meaning.dialogue")
