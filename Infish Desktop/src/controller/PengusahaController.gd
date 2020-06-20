extends Control

onready var DB      = $DBconnection
onready var DB2     = $DBconnection2 #its needed to make multi level request!
onready var DB3     = $DBconnection3 #based on https://docs.godotengine.org/en/stable/tutorials/networking/http_request_class.html
									 #we need separated on for multi level request
onready var Helper  = load("res://src/lib/DBhelper.gd").new()
onready var Handler = load("res://src/lib/InputHandler.gd").new()
onready var Model   = load("res://src/model/users.gd")

var colnum = 6

var state_request setget setState, getState
var last_insert setget setLastInsert, getLastInsert
var role setget setRole, getRole

var data = [
["1","123404321", "24", "120.000", "18%", "24 Bln", "Edit"],
["2","123404322", "4", "240.000", "16%", "12 Bln", "Edit"],
["3","123404323", "9", "840.000", "17%", "6 Bln", "Edit"],
["4","123404324", "40", "1000.000", "18%", "12 Bln", "Edit"],
["5","123404325", "19", "120.000", "15%", "24 Bln", "Edit"],
["6","123404326", "17", "560.000", "18%", "12 Bln", "Edit"],
["7","123404327", "0", "240.000", "14%", "24 Bln", "Edit"]]

func _ready():
	var session = DB.readSession()
	setRole(session ["role"])
	refresh()

func refresh():
	setState("get_all_pengusaha")
	DB.handleRequest("POST", Helper.select("pengusaha"))

func render_tables(data):
	for c in range(colnum+1, $table.get_item_count()):
		$table.remove_item(c)
	for c in range(len(data)):
		for r in range(len(data[c])):
			if( data[c][r] == null ):
				data[c][r] = "0"
			if(r != colnum):
				$table.add_item (data[c][r], null, false)
			else:
				$table.add_item (data[c][r], null, true)

func _on_table_item_selected(index):
	if( index > (colnum*2) ):
		$modal.show()
		if $modal.has_node("edit"):
			$modal/edit.show()
		if $modal.has_node("add"):
			$modal/add.hide()
		_open_pengusaha($table.get_item_text(index-5))
		

func _open_pengusaha(nomor):
	setState("open_pengusaha")
	DB.handleRequest("POST", Helper.select_where_join("pengusaha","users","pengusaha.id_user","users.id","nomor_usaha", nomor))
	pass

func _on_tambah_pressed():
	$modal.show()
	if $modal.has_node("edit"):
		$modal/edit.hide()
	if $modal.has_node("add"):
		$modal/add.show()

func close_modal():
	$modal.hide()
	if $modal.has_node("edit"):
		$modal/edit.hide()
	if $modal.has_node("add"):
		$modal/add.hide()

func _on_btn_confirm_button_up():
	var path     = "modal/add/"
	var fname    = get_node(path+"in_fname").get_text()
	var lname    = get_node(path+"in_lname").get_text()
	var phone    = get_node(path+"in_phone").get_value()
	var surel    = get_node(path+"in_surel").get_text()
	var sandi    = get_node(path+"in_sandi").get_text()
	var no_usaha = get_node(path+"in_no_usaha").get_text()
	var sektor   = get_node(path+"in_sektor").get_selected()
	var jml_pkj  = get_node(path+"in_jml_pkj").get_value()
	sandi = Marshalls.utf8_to_base64(sandi)
	var inputs = [fname, lname, phone, surel, sandi, "pengusaha"]
	var reqs   = [1,1,1,1,1,0]
	if(Handler.validate(inputs, reqs)):
		var attr = ["nama_depan", "nama_belakang", "notelp", "email", "password", "role"]
		setState("add_user")
		DB.handleRequest("POST", Helper.insert("users", attr, inputs))

		setState("get_last_insert")
		DB2.handleRequest("POST", Helper.last("users"))

		setState("add_pengusaha")
		attr = ["id_user", "nomor_usaha", "sektor", "pekerja"]
		inputs = [int(getLastInsert())+1, no_usaha, sektor, jml_pkj]
		DB3.handleRequest("POST", Helper.insert("pengusaha", attr, inputs))
		close_modal()
		$MsgBox.open("SUKSES","Tambah Pengusaha","Pengusaha "+fname+" "+lname+" berhasil ditambahkan.")
	else:
		$MsgBox.open("ERROR","Tambah Pengusaha","Isian formulir belum lengkap.")

func _on_btn_edit_button_up():
	var path     = "modal/edit/"
	var fname    = get_node(path+"in_fname").get_text()
	var lname    = get_node(path+"in_lname").get_text()
	var phone    = get_node(path+"in_phone").get_value()
	var surel    = get_node(path+"in_surel").get_text()
	var sandi    = get_node(path+"in_sandi").get_text()
	var no_usaha = get_node(path+"in_no_usaha").get_text()
	var sektor   = get_node(path+"in_sektor").get_selected()
	var jml_pkj  = get_node(path+"in_jml_pkj").get_value()
	var max_stok = get_node(path+"in_jml_pkj").get_value()
	var hrg_stok = get_node(path+"in_jml_pkj").get_value()
	var periode  = get_node(path+"in_periode").get_value()
	var interest = get_node(path+"in_interest").get_value()
	sandi = Marshalls.utf8_to_base64(sandi)
	var inputs = [fname, lname, phone]
	var reqs   = [1,1,1,1,1,0]
	if(Handler.validate(inputs, reqs)):
		var attr = ["nama_depan", "nama_belakang", "notelp"]
		setState("add_user")
		DB.handleRequest("POST", Helper.update("users", attr, inputs, 'email', surel))
		setState("add_pengusaha")
		attr = ["sektor", "pekerja"]
		inputs = [sektor, jml_pkj, max_stok, hrg_stok, periode, interest]
		DB3.handleRequest("POST", Helper.update("pengusaha", attr, inputs, 'nomor_usaha', no_usaha))
		close_modal()
		$MsgBox.open("SUKSES","Ubah Pengusaha","Pengusaha "+fname+" "+lname+" berhasil diperbarui.")
	else:
		$MsgBox.open("ERROR","Ubah Pengusaha","Isian formulir belum lengkap.")

func _on_btn_pick_file_pressed():
	$FileDialog.popup()

func _on_btn_upload_transaksi():
	var path       = "modal/"
	var session    = DB.readSession()
	var uid        = session["id"]
	var id         = get_node(path+"id").get_text()
	var b_tujuan   = get_node(path+"in_b_tujuan").get_text()
	var b_pengirim = get_node(path+"in_b_pengirim").get_text()
	var norek      = get_node(path+"in_norek").get_text()
	var nominal    = get_node(path+"in_nominal").get_text()
	var tgl        = get_node(path+"in_tgl").get_text()
	var file = File.new()
	file.open("user://temp-upload.txt", File.READ)
	var bukti      = file.get_as_text()
	var attr       = ["id_pengusaha", "id_user", "bank_tujuan", "bank_pengirim", "nomor_rekening", "tanggal", "nominal", "bukti"]
	var inputs     = [id, uid, b_tujuan, b_pengirim, norek, tgl, nominal, bukti]
	DB.handleRequest("POST", Helper.insert("investasi", attr, inputs))

func request_completed(result, code, headers, body):
	print("Respond Code: "+str(code))
	var data
	var session = DB.readSession()
	if code == 200:
		data = JSON.parse(body.get_string_from_utf8()).result
		match getState():
			"get_all_pengusaha":
				var i = 1
				var table = []
				print(data)
				var action
				if role == "petugas_survey" or role == "petugas_kearsipan":
					action = "Ubah"
				else:
					action = "Lihat"
				for pengusaha in data:
					var col = [str(i), pengusaha["nomor_usaha"], pengusaha["maks_stok"], pengusaha["harga_stok"], pengusaha["interest"], pengusaha["periode_bagi"], action]
					table.append(col)
					i +=1
				render_tables(table)
			"add_user":
				print(data)
			"get_last_insert":
				setLastInsert(data[0]["id"])
				print(getLastInsert())
			"open_pengusaha":
				print(data[0])
				for r in data:
					if( r == null ):
						data[0][r] = 0
				var path     = "modal/edit/"
				if(getRole() != "investor"):
					get_node(path+"in_fname").set_text(data[0]["nama_depan"])
					get_node(path+"in_lname").set_text(data[0]["nama_belakang"])
					get_node(path+"in_phone").set_value(float(data[0]["notelp"]))
					get_node(path+"in_surel").set_text(data[0]["email"])
					get_node(path+"in_sandi").set_text("")
					if(data[0]["sektor"] == "pembibitan"):
						get_node(path+"in_sektor").select(0)
					else:
						get_node(path+"in_sektor").select(1)
					get_node(path+"in_no_usaha").set_text(data[0]["nomor_usaha"])
					get_node(path+"in_jml_pkj").set_value(float(data[0]["pekerja"]))
					get_node(path+"in_max_stok").set_value(float(data[0]["maks_stok"]))
					get_node(path+"in_hrg_stok").set_value(float(data[0]["harga_stok"]))
					get_node(path+"in_periode").set_value(float(data[0]["periode_bagi"]))
					get_node(path+"in_interest").set_value(float(data[0]["interest"]))
				else:
					path = "modal/"
					get_node(path+"id").set_text(data[0]["id"])
		clearState()





# ========= Setter & Getter ========
func setState(value):
	state_request = value
func getState():
	return state_request
func clearState():
	state_request = 'idle'

func setLastInsert(value):
	last_insert = value
func getLastInsert():
	return last_insert

func setRole(value):
	role = value
func getRole():
	return role



func _on_transfer_file_selected(path):
	print(path)
	$modal/in_bukti.set_text(path)
	var file = File.new()
	var image = File.new()
	image.open(path, File.READ)
	file.open("user://temp-upload.txt", File.WRITE)
	file.store_string(Marshalls.raw_to_base64(image.get_buffer(image.get_len())))
	file.close()
	
	file.open("user://temp-upload.txt", File.READ)
	var load_data = file.get_as_text()
	print(load_data)
	var result = Image.new()
	result.load_png_from_buffer(Marshalls.base64_to_raw(load_data))
	file.close()




