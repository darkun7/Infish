extends Control
onready var Handler = preload("res://src/lib/InputHandler.gd").new()

func _ready():
	pass

func _on_btn_goto_login_button_up():
	var path = "container/split/r_side/vcontainer/"
	get_node(path+"panel_register").visible = false
	get_node(path+"panel_login").visible = true

func _on_btn_goto_register_button_up():
	var path = "container/split/r_side/vcontainer/"
	get_node(path+"panel_login").visible = false
	get_node(path+"panel_register").visible = true

# ========= Registrasi ========
func _on_btn_register_button_up():
	var path     = "container/split/r_side/vcontainer/panel_register/"
	var fname    = get_node(path+"in_fname").get_text()
	var lname    = get_node(path+"in_lname").get_text()
	var phone    = get_node(path+"in_phone").get_text()
	var surel    = get_node(path+"in_surel").get_text()
	var sandi    = get_node(path+"in_sandi").get_text()
	var inputs = [fname, lname, phone, surel, sandi]
	var reqs   = [1,1,1,1,1]
	if(Handler.validate(inputs, reqs)):
		$MsgBox.open("sukses","Pendaftaran","Anda berhasil melakukan pendaftaran.")
		_on_btn_goto_login_button_up()
	else:
		$MsgBox.open("error","Pendaftaran","Harap mengisi formulir pendaftaran.")

# ========= Login ========
func _on_btn_login_button_up():
	var path     = "container/split/r_side/vcontainer/panel_login/"
	var surel    = get_node(path+"in_surel").get_text()
	var sandi    = get_node(path+"in_sandi").get_text()
	var inputs = [surel, sandi]
	var reqs = [1,1]
	if(Handler.validate(inputs, reqs)):
		get_tree().change_scene("res://src/view/Dasbor.tscn")
	else:
		$MsgBox.open("error","Masuk","Kredensial alamat surel/ kata sandi tidak tepat.")
