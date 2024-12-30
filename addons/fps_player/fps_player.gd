@tool
extends EditorPlugin

func _enter_tree() -> void: # Initialization of the plugin goes here.
	add_custom_type("FPSPlayer","CharacterBody3D",preload("fps_player.gd"),preload("fpsplayer_icon.png"))

func _exit_tree() -> void: # Clean-up of the plugin goes here.
	remove_custom_type("FPSPlayer")
