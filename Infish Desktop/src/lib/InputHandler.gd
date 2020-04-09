extends Node

func _ready():
	pass # Replace with function body.

func validate(inputs, reqs):
	for i in range(len(inputs)):
		if(reqs[i] == 1 && inputs[i] == ''):
			return false
	return true