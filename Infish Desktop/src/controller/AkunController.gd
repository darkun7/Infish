extends Control

onready var DB      = $DBconnection
onready var Helper  = preload("res://src/lib/DBhelper.gd").new()
onready var Handler = preload("res://src/lib/InputHandler.gd").new()

var state_request setget setState, getState

func _ready():
	var session = DB.readSession()
	var email = session['email']
	setState('set_user')
	DB.handleRequest("POST", Helper.select_where("users", "email","=", email))

func _on_btn_simpan_button_up():
	var id       = $id.get_text()
	var fname    = $in_fname.get_text()
	var lname    = $in_lname.get_text()
	var surel    = $in_surel.get_text()
	var sandi    = $in_sandi.get_text()
	sandi = Marshalls.utf8_to_base64(sandi)
	var inputs = [fname, lname, surel, sandi]
	var reqs   = [0,0,0,1]
	if(Handler.validate(inputs, reqs)):
		$MsgBox.open("SUKSES","Akun","Perubahan data akun disimpan.")
		setState('update_user')
		var attr = ["nama_depan", "nama_belakang", "email", "password"]
		DB.handleRequest("POST", Helper.update("users", attr, inputs, 'id', id))
	else:
		$MsgBox.open("ERROR","Akun","Harap mengisi formulir.")

func request_completed(result, code, headers, body):
	print("Respond Code: "+str(code))
	var data
	var session = DB.readSession()
	if code == 200:
		data = JSON.parse(body.get_string_from_utf8()).result
		
		match getState():
			"set_user":
				var user = data[0]
				$id.set_text(user["id"])
				$in_fname.set_text(user["nama_depan"])
				$in_lname.set_text(user["nama_belakang"])
				$in_surel.set_text(user["email"])
				var newsession = {
					username = user["nama_depan"]+user["nama_belakang"],
					email    = user["email"],
					pwd      = user["password"],
					role     = user["role"]
				}
				DB.saveSession(newsession)
			"user_update":
				print("P")
		clearState()


# ========= Setter & Getter ========
func setState(value):
	state_request = value
func getState():
	return state_request
func clearState():
	state_request = 'idle'
