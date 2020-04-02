extends Control

func _ready():
	pass # Replace with function body.

func _on_btn_goto_login_button_up():
	var path = "container/split/r_side/vcontainer/"
	get_node(path+"panel_register").visible = false
	get_node(path+"panel_login").visible = true

func _on_btn_goto_register_button_up():
	var path = "container/split/r_side/vcontainer/"
	get_node(path+"panel_login").visible = false
	get_node(path+"panel_register").visible = true

func _on_btn_register_button_up():
	$PopUP.open("sukses","Auth","Anda berhasil melakukan pendaftara.")


func _on_btn_login_button_up():
	#login
	pass # Replace with function body.
