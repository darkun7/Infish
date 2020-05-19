extends Control

onready var DB      = $DBconnection
onready var Helper  = load("res://src/lib/DBhelper.gd").new()
onready var Handler = load("res://src/lib/InputHandler.gd").new()
onready var Model   = load("res://src/model/users.gd")

func _ready():
	OS.window_fullscreen = false
	DB.connect("request_completed", self, "_catch_response")
	
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
	var phone    = get_node(path+"in_phone").get_value()
	var surel    = get_node(path+"in_surel").get_text()
	var sandi    = get_node(path+"in_sandi").get_text()
	sandi = Marshalls.utf8_to_base64(sandi)
	var inputs = [fname, lname, phone, surel, sandi, "investor"]
	var reqs   = [1,1,1,1,1,0]
	if(Handler.validate(inputs, reqs)):
		var attr = ["nama_depan", "nama_belakang", "notelp", "email", "password", "role"]
		DB.handleRequest("POST", Helper.insert("users", attr, inputs))
	else:
		$MsgBox.open("ERROR","Pendaftaran","Harap mengisi borang pendaftaran.")

# ========= Login ========
func _on_btn_login_button_up():
	var path     = "container/split/r_side/vcontainer/panel_login/"
	var surel    = get_node(path+"in_surel").get_text()
	var sandi    = get_node(path+"in_sandi").get_text()
	var inputs = [surel, sandi]
	var reqs = [1,1]
	if(Handler.validate(inputs, reqs)):
		DB.handleRequest("GET", Helper.select_where("users", "email", "=", surel))
		var data = {
            email = surel,
			pwd = sandi,
            role = surel
        }
		DB.saveSession(data)
		#get_tree().change_scene("res://src/view/Dasbor.tscn")
	else:
		$MsgBox.open("ERROR","Masuk","Harap melengkapi borang masuk.")

# ========= Catch Request ========
func _request_completed(result, code, headers, body):
	print("Respond Code: "+str(code))
	var data
	var session = DB.readSession()
	
	if code == 200:
		data = JSON.parse(body.get_string_from_utf8()).result
		
		if str(data) == "True":    #Register berhasil
			$MsgBox.open("SUKSES","Pendaftaran","Anda berhasil melakukan pendaftaran.")
			_on_btn_goto_login_button_up()
		elif str(data) == "False": #Register gagal
			$MsgBox.open("ERROR","Koneksi","Gagal terhubung ke server. #Error Code:"+str(code))
		else:                      #If response contain Object
			var user     = data[0]
			var email    = user[4]
			var password = Marshalls.base64_to_utf8(user[5])
			
			if(session["email"] == email && session["pwd"] == password):
				var newsession = {
					username = user[1]+user[2],
					email    = email,
					pwd      = user[5],
					role     = user[6]
				}
				DB.saveSession(newsession)
				get_tree().change_scene("res://src/view/Dasbor.tscn")
			else:
				$MsgBox.open("ERROR","Masuk","Kredensial alamat surel/ kata sandi tidak tepat.")
		pass

	else:
		$MsgBox.open("ERROR","Koneksi","Gagal terhubung ke server. #Error Code:"+str(code))