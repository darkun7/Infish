extends "res://src/lib/DBconnection.gd"

onready var Helper  = preload("res://src/lib/DBhelper.gd").new()

func _ready():
	self.connect("request_completed", self, "_catch_response")

var id
var nama_depan 
var nama_belakang
var no_telp
var email setget setEmail, getEmail
var password setget setPassword, getPassword
var role

func _init(id):
	self.id = id 

func getAuthValue(email : String, password : String):
	self.email = email
	self.password = password
	var data_received
	
	.handleRequest("POS", Helper.select_where('users', '%like%', 'email', email))
	data_received = yield(self, "request_completed")
	var email_received = JSON.parse(data_received[3].get_string_from_utf8()).result
	
	.handleRequest("POS", Helper.select_where('users', '%like%', 'password', password))
	data_received = yield(self, "request_completed")
	var password_received = JSON.parse(data_received[3].get_string_from_utf8()).result
	
	if(email == email_received && password == password_received):
		print(">> Login Success")
	else:
		print(">> Incorect Credential")
	pass

func getName():
	return nama_depan+nama_belakang

func setEmail(value):
	email = value
func getEmail():
	return email

func setPassword(value):
	password = value
func getPassword():
	return password
