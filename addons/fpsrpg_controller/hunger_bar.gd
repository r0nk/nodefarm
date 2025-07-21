extends ProgressBar

func _process(delta: float) -> void:
	value=1-(get_parent().hunger/get_parent().starvation_threshhold)
