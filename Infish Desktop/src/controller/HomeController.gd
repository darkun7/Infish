extends Control

var user
var role
var level_user

var PageInfo : Array setget setPageInfo
var Name setget setName

onready var DB      = $DBconnection
onready var Helper  = load("res://src/lib/DBhelper.gd").new()

func _ready():
	$base.connect("user_setting", self, "_on_user_setting_pressed")
	var session = DB.readSession()
	role = session["role"]
	
	DB.handleRequest("POST", Helper.select_where("users", "email", "=", session["email"]))
	
	level_user = role.replace('_',' ').capitalize()
	setName(session["username"] + " ("+level_user+")")
	$base/PanelContainer/VBoxContainer/bg_side/user_box/Control/ProfilPict.texture = load("res://asset/img/"+role+".png")
	set_menu(role)
	_on_Dasbor_pressed()
	#get user from session and set to variable user
	pass

func set_page(page : String)->void:
	var parent = $base/pagecontent/scroll
	var scene = load(page).instance()
	if(parent.get_child_count()!=2):
		for n in parent.get_children():
			parent.remove_child(n)
	parent.add_child(scene)

func set_menu(role : String):
	var path = "base/menucontent/scroll/container/btn_"
	var btn  = ['pengusaha', 'pendapatan', 'laporan',
				'bidangUsaha', 'periodeIkan', 'investasi',
				'transfer']
	var active
	for b in btn:
		get_node(path+b).visible = false
	match role:
		'petugas_kearsipan':
			active = [0, 1]
			for a in active:
				get_node(path+btn[a]).visible = true
		'petugas_survey':
			active = [0, 4] #active = [0, 3, 4]
			for a in active:
				get_node(path+btn[a]).visible = true
		'petugas_keuangan':
			active = [0, 1, 5, 6]
			for a in active:
				get_node(path+btn[a]).visible = true
		'investor':
			active = [0, 5] #[0, 1, 5]
			for a in active:
				get_node(path+btn[a]).visible = true

# ======== Event Handler =======
func _on_Dasbor_pressed():
	var session = DB.readSession()
	setName(session["username"] + " ("+level_user+")")
	setPageInfo(["Dasbor", "Halaman dasbor untuk "+level_user])
	set_page("res://src/view/Grafik.tscn")

func _on_btn_pengusaha_pressed():
	setPageInfo(["Pengusaha", "Halaman pengusaha untuk "+level_user])
	match role:
		'petugas_kearsipan':
			set_page("res://src/view/petugas_kearsipan/pengusaha.tscn")
			pass
		'petugas_survey':
			set_page("res://src/view/petugas_survey/pengusaha.tscn")
			pass
		'petugas_keuangan':
			set_page("res://src/view/petugas_keuangan/pengusaha.tscn")
			pass
		'investor':
			set_page("res://src/view/investor/pengusaha.tscn")
			pass

func _on_btn_pendapatan_pressed():
	setPageInfo(["Pendapatan", "Halaman pendapatan untuk "+level_user])
	match role:
		'petugas_kearsipan':
			set_page("res://src/view/petugas_kearsipan/pendapatan.tscn")
			pass
		'petugas_keuangan':
			set_page("res://src/view/petugas_keuangan/pendapatan.tscn")
			pass

func _on_btn_investasi_pressed():
	setPageInfo(["Investasi", "Halaman investasi untuk "+level_user])
	match role:
		'investor':
			set_page("res://src/view/investor/investasi.tscn")
			pass
		'petugas_keuangan':
			set_page("res://src/view/petugas_keuangan/investasi.tscn")
			pass

func _on_btn_laporan_pressed():
	setPageInfo(["Laporan", "Tinjau lapran pendapatan dari pengusaha"])
	set_page("res://src/view/petugas_kearsipan/laporan.tscn")
	pass # Replace with function body.

func _on_btn_bidangUsaha_pressed():
	setPageInfo(["Bidang Usaha", "Kelola bidang usaha perikanan"])
	set_page("res://src/view/petugas_survey/bidang_usaha.tscn")
	pass # Replace with function body.

func _on_btn_periodeIkan_pressed():
	setPageInfo(["Periode Ikan", "Kebutuhan waktu untuk panen berdasar jenis ikan"])
	set_page("res://src/view/petugas_survey/periodeIkan.tscn")
	pass # Replace with function body.

func _on_btn_transfer_pressed():
	setPageInfo(["Transfer", "Tinjau transfer dan keuangan investasi"])
	set_page("res://src/view/petugas_keuangan/transfer.tscn")
	pass # Replace with function body.

func _on_user_setting_pressed():
	setPageInfo(["Kelola Akun", ""])
	set_page("res://src/view/Akun.tscn")
	pass

# ======== Setter/Getter =======
func setPageInfo(value : Array):
	PageInfo  = value
	var title = value[0]
	var desc  = value[1]
	$base/Header/Wraper/PageName.text = title;
	$base/Header/Wraper/PageDesc.text = desc
	pass

func setName(value):
	Name = value
	$base/PanelContainer/VBoxContainer/bg_side/user_box/Control/UserName.text = value

func _request_completed(result, code, headers, body):
	print("Respond Code: "+str(code))
	var data
	var session = DB.readSession()
	
	if code == 200:
		data = JSON.parse(body.get_string_from_utf8()).result
		var user     = data[0]
		var email    = user["email"]
		var password = user["password"]
		var role     = user["role"]
		var id       = user["id"]
		
		if(session["email"] == email && session["pwd"] == password && role == role):
			var newsession = {
					username = user["nama_depan"]+" "+user["nama_belakang"],
					email    = email,
					pwd      = password,
					role     = role,
					id       = id
				}
			DB.saveSession(newsession)
			setName(newsession["username"] + " ("+role+")")
		else:
			get_tree().change_scene("res://src/view/Auth.tscn")
	else:
		$MsgBox.open("ERROR","Koneksi","Gagal terhubung ke server. #Error Code:"+str(code))
