extends Control

onready var DB      = preload("res://src/lib/DBconnection.gd").new()
onready var Helper  = preload("res://src/lib/DBhelper.gd").new()
onready var Handler = preload("res://src/lib/InputHandler.gd").new()
onready var Model   = load("res://src/model/users.gd")

func _ready():
	self.connect("request_completed", DB, "_catch_response")
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
		var attr = ["nama_depan", "nama_belakang", "notelp", "email", "password", "role"]
		DB.handleRequest("POST", Helper.insert("users", attr, inputs))
		$MsgBox.open("SUKSES","Pendaftaran","Anda berhasil melakukan pendaftaran.")
		_on_btn_goto_login_button_up()
	else:
		$MsgBox.open("ERROR","Pendaftaran","Harap mengisi formulir pendaftaran.")

# ========= Login ========
func _on_btn_login_button_up():
	var path     = "container/split/r_side/vcontainer/panel_login/"
	var surel    = get_node(path+"in_surel").get_text()
	var sandi    = get_node(path+"in_sandi").get_text()
	var inputs = [surel, sandi]
	var reqs = [1,1]
	if(Handler.validate(inputs, reqs)):
		var data = {
            username = "Tester",
			password = sandi,
            role = surel
        }
		DB.saveSession(data)
		get_tree().change_scene("res://src/view/Dasbor.tscn")
	else:
		$MsgBox.open("ERROR","Masuk","Kredensial alamat surel/ kata sandi tidak tepat.")

# ========= Catch Request ========
func _catch_response(result, code, headers, body):
	print("dapet Respon")
	var data
	if code == 200:
		data = JSON.parse(body.get_string_from_utf8()).result
		
	else:
		$MsgBox.open("ERROR","Koneksi","Gagal terhubung ke jaringan. #Error Code:"+code)