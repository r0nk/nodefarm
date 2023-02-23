extends Node


export var health = 100

func hurt(amount):
	health -=amount
	if(health <=0):
		get_parent().queue_free()
