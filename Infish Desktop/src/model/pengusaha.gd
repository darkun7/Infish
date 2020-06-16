extends "res://src/lib/DBconnection.gd"

onready var Helper  = preload("res://src/lib/DBhelper.gd").new()

func _ready():
	self.connect("request_completed", self, "_catch_response")

var id_user
var nomor_usaha
var sektor 
var harga_stok
var maks_stok
var interest
var periode_bagi
var pekerja

func _init(id):
	self.id_user = id 

func getAll():
	pass

func getById(id):
	pass

func updateById(id):
	pass
