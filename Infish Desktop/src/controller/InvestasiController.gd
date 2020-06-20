extends Control

onready var DB      = $DBconnection
onready var Helper  = load("res://src/lib/DBhelper.gd").new()
onready var Handler = load("res://src/lib/InputHandler.gd").new()
onready var Model   = load("res://src/model/users.gd")

var colnum = 5
var state_request setget setState, getState

func _ready():
	var session = DB.readSession()
	refresh()

func refresh():
	setState("get_investasi")
	DB.handleRequest("POST", Helper.select("investasi"))

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
			_open_investasi($table.get_item_text(index-4))

func _open_investasi(kode):
	setState("open_investasi")
	DB.handleRequest("POST", Helper.select_where("investasi", "nomor_rekening","=", kode))
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

func request_completed(result, code, headers, body):
	print("Respond Code: "+str(code))
	var data
	var session = DB.readSession()
	if code == 200:
		print(getState())
		data = JSON.parse(body.get_string_from_utf8()).result
		print(data)
		match getState():
			"get_investasi":
				var i = 1
				var table = []
				print(data)
				for inv in data:
					var col = ["",str(i), inv["nomor_rekening"], inv["nominal"], inv["tanggal"], inv["status"],"Lihat"]
					table.append(col)
					i +=1
				render_tables(table)
			"open_investasi":
				var inv = data[0]
				$modal/edit/id_investasi.set_text(inv["id"])
				var base64img = inv["bukti"]
				var bukti = Image.new()
				var itex = ImageTexture.new()
				var p = bukti.load_png_from_buffer(Marshalls.base64_to_raw(base64img))
				itex.create_from_image(bukti)
				$modal/edit/bukti.set_texture(itex)
				print($modal/edit/bukti.texture)
		clearState()

# ========= Setter & Getter ========
func setState(value):
	state_request = value
func getState():
	return state_request
func clearState():
	state_request = 'idle'


func _on_btn_confirm_button_up():
	var status   = $modal/edit/in_status.get_selected()
	var id       = $modal/edit/id_investasi.get_text()
	var attr   = ["status"]
	var inputs = [status]
	DB.handleRequest("POST", Helper.update("investasi", attr, inputs, 'id', id))
