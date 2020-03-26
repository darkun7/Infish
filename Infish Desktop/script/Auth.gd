extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_btn_goto_login_button_up():
	var path = "MarginContainer/split/r_side/vcontainer/"
	get_node(path+"panel_register").visible = false
	get_node(path+"panel_login").visible = true


func _on_btn_goto_register_button_up():
	var path = "MarginContainer/split/r_side/vcontainer/"
	get_node(path+"panel_login").visible = false
	get_node(path+"panel_register").visible = true
