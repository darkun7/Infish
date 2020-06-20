extends Node

func _ready():
	pass # Replace with function body.

func validate(inputs):
	if (inputs == "Tulis Pesan" || inputs == ""):
		return false
	else:
		return true
