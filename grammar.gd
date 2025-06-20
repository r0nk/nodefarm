extends Node

func name():
	return ["alice","bob"].pick_random()

func adverb():
	return ["quickly","quietly","angrily","loudly"].pick_random()

func place():
	return ["store","library","mall","club"].pick_random()

func _ready():
	print("%s %s went to the %s" % [name(),adverb(),place()])

