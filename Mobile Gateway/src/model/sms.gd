extends Node

var MySQL       = preload('res://src/lib/MySQL.gd').new()

const pendapatan  = ["PENDAPATAN", 3]
const klaim       = ["KLAIM", 2]
const pengeluaran = ["PENGELUARAN", 2]
const setoran     = ["SETOR", 2]
const penjualan   = ["PENJUALAN", 1]

var db

func _ready():
	pass

func _catch_response():
	print(JSON.parse(yield(db, "request_completed")[3].get_string_from_utf8()).result)

func _gw_in_infish(pesan, pengirim):
	var msg   = pesan.split(" ", false)
	var menu  = msg[0]
	var param = 0
	var query = "SELECT * FROM `users` WHERE `notelp` = '"+pengirim+"'"
	db = MySQL
	db.handle_request("POST", query)
	#print(JSON.parse(yield(db, "request_completed")[3].get_string_from_utf8()).result)
	return "Laporan diterima"
	if (menu == pendapatan[0]):
		param = pendapatan[1]
		query = "INSERT INTO `sms`(`id_user`, `message`, `platform`) VALUES (1,'message','gw-test')"

	elif (menu == klaim[0]):
		param = klaim[1]

	elif (menu == pengeluaran[0]):
		param = pengeluaran[1]

	elif (menu == penjualan[0]):
		param = setoran[1]

	elif (menu == penjualan[0]):
		param = setoran[1]

	#else: return("Format pesan tidak tersedia.")
	
	
	pass

func _gw_query_process():
	var query = "SELECT * FROM `users`"
	$MySQL.RequestPOST(query)
	var data = $MySQL._get_response()

func _gw_out_infish():
	pass


	
	
	
