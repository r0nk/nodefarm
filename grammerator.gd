extends Label3D

var pretext

var grammar = {
	"SUBJECT":["stuff","other stuff","cat","dog"],
	"VERB":["ran","jumped","went", "VERB and VERB"],
	}

func generate():
	text=pretext
	var matches = [1]
	while matches.size() >=1:
		for key in grammar.keys():
			text = text.replace(key,grammar[key].pick_random())
		matches = grammar.keys().filter(func (x):return text.contains(x))
	print(text)

func _ready():
	text = "The SUBJECT VERB."
	pretext=text
	generate()

