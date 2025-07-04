extends Node

@export var starvation_threshhold=100
@export var hunger=0
@export var hunger_rate=0.1

func digest(calories):
	hunger-=calories

func _process(delta: float) -> void:
	hunger+=delta*hunger_rate
	if(hunger>starvation_threshhold):
		print(get_parent().name," has starved to death.");
		get_parent().queue_free()



