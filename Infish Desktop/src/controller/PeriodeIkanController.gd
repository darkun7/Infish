extends Control

onready var DB      = $DBconnection
onready var Helper  = load("res://src/lib/DBhelper.gd").new()
onready var Handler = load("res://src/lib/InputHandler.gd").new()
onready var Model   = load("res://src/model/users.gd")

var colnum = 3
var state_request setget setState, getState

var data = [
["1","Lele", "2", "Edit"],
["2","Nila", "3", "Edit"],
["3","Gurame", "2", "Edit"],
["4","Gabus", "2.5", "Edit"],
["5","Belut", "1.5", "Edit"],
["6","Udang", "2", "Edit"],
["7","Cumi", "3", "Edit"]]

func _ready():
	var session = DB.readSession()
	refresh()

func refresh():
	setState("get_periode")
	DB.handleRequest("POST", Helper.select("periode_ikan"))

func render_tables(data):
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
		_open_ikan($table.get_item_text(index-2))

func _open_ikan(nama):
	setState("open_ikan")
	DB.handleRequest("POST", Helper.select_where("periode_ikan", "jenis_ikan","=", nama))
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

func _on_btn_add_button_up():
	var path     = "modal/add/"
	var id       = get_node(path+"id").get_text()
	var ikan     = get_node(path+"in_jenis_ikan").get_text()
	var periode  = get_node(path+"in_periode").get_value()
	var attr     = ["jenis_ikan", "periode"]
	var inputs   = [ikan, periode]
	var reqs     = [1,1]
	if(Handler.validate(inputs, reqs)):
		setState("add_ikan")
		DB.handleRequest("POST", Helper.insert("periode_ikan", attr, inputs))
		$MsgBox.open("SUKSES","Tambah Periode Ikan","Pengusaha "+ikan+" berhasil ditambahkan.")
		close_modal()
	else:
		$MsgBox.open("ERROR","Tambah Periode Ikan","Isian formulir belum lengkap.")

func _on_btn_edit_button_up():
	var path     = "modal/edit/"
	var id       = get_node(path+"id").get_text()
	var ikan     = get_node(path+"in_jenis_ikan").get_text()
	var periode  = get_node(path+"in_periode").get_value()
	var attr     = ["jenis_ikan", "periode"]
	var inputs   = [ikan, periode]
	var reqs     = [1,1]
	if(Handler.validate(inputs, reqs)):
		setState("edit_ikan")
		DB.handleRequest("POST", Helper.update("periode_ikan", attr, inputs, 'id', id))
		$MsgBox.open("SUKSES","Ubah Periode Ikan","Pengusaha "+ikan+" berhasil diperbarui.")
		close_modal()
	else:
		$MsgBox.open("ERROR","Ubah Periode Ikan","Isian formulir belum lengkap.")

func request_completed(result, code, headers, body):
	print("Respond Code: "+str(code))
	var data
	var session = DB.readSession()
	if code == 200:
		print(getState())
		data = JSON.parse(body.get_string_from_utf8()).result
		match getState():
			"get_periode":
				var i = 1
				var table = []
				print(data)
				for ikan in data:
					var col = [str(i), ikan["jenis_ikan"], ikan["periode"], "Ubah"]
					table.append(col)
					i +=1
				render_tables(table)
			"open_ikan":
				for r in data:
					if( r == null ):
						data[0][r] = 0
				var path     = "modal/edit/"
				get_node(path+"id").set_text(data[0]["id"])
				get_node(path+"in_jenis_ikan").set_text(data[0]["jenis_ikan"])
				get_node(path+"in_periode").set_value(float(data[0]["periode"]))
			"add_ikan":
				close_modal()
				refresh()
			"edit_ikan":
				close_modal()
				refresh()
		clearState()

# ========= Setter & Getter ========
func setState(value):
	state_request = value
func getState():
	return state_request
func clearState():
	state_request = 'idle'
