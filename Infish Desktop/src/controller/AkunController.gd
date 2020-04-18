extends Control

onready var DB      = preload("res://src/lib/DBconnection.gd").new()
onready var Helper  = preload("res://src/lib/DBhelper.gd").new()
onready var Handler = preload("res://src/lib/InputHandler.gd").new()

func _ready():
	pass # Replace with function body.

func _on_btn_simpan_button_up():
	var fname    = $in_fname.get_text()
	var lname    = $in_lname.get_text()
	var surel    = $in_surel.get_text()
	var sandi    = $in_sandi.get_text()
	var inputs = [fname, lname, surel, sandi]
	var reqs   = [0,0,0,1]
	if(Handler.validate(inputs, reqs)):
		$MsgBox.open("SUKSES","Akun","Perubahan data akun disimpan.")
		get_tree().change_scene("res://src/view/Dasbor.tscn")
	else:
		$MsgBox.open("ERROR","Akun","Harap mengisi formulir.")