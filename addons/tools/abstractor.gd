@tool
extends Node

@export_range(-1.0,1.0) var value=0.0

@export var modifiers:Array[Modifier]

@export var verbose = false

func _process(delta):
	var curve_value = (value+1.0)/2.0
	for mod in modifiers:
		var node = get_node(mod.node_path)
		var sample=mod.curve.sample(curve_value)
		if(verbose):
			print("setting a value to:",mod.curve.sample(curve_value)," on ",node)
			print("getting variable:",node.get(mod.variable))
		node.set(mod.variable,sample)
