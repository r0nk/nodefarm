extends Node2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if($enemy.health<=0 or $tcg_player.health<=0):
		get_tree().reload_current_scene()
