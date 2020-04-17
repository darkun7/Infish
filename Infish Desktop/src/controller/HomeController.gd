extends Control

var user
var role

var PageInfo : Array setget setPageInfo
var Name setget setName

var active_page

func _ready():
	role = "petugas_keuangan"
	$base/PanelContainer/VBoxContainer/bg_side/user_box/Control/ProfilPict.texture = load("res://asset/img/"+role+".png")
	set_menu(role)
	#get user from session and set to variable user
	pass

func set_menu(role : String):
	var path = "base/menucontent/scroll/container/btn_"
	var btn  = ['pengusaha', 'pendapatan', 'laporan',
	            'bidangUsaha', 'periodeIkan', 'investasi',
	            'transfer']
	var active
	for b in btn:
		get_node(path+b).visible = false
	setPageInfo(["Dasbor", "Halaman dasbor untuk "+role])
	match role:
		'petugas_kearsipan':
			active = [0, 1]
			for a in active:
				get_node(path+btn[a]).visible = true
		'petugas_survey':
			active = [0, 3, 4]
			for a in active:
				get_node(path+btn[a]).visible = true
		'petugas_keuangan':
			active = [0, 1, 6]
			for a in active:
				get_node(path+btn[a]).visible = true
		'investor':
			active = [0, 1, 5]
			for a in active:
				get_node(path+btn[a]).visible = true

# ======== Event Handler =======
func _on_btn_pengusaha_pressed():
	setPageInfo(["Pengusaha", "Halaman pengusaha untuk "+role])
	match user:
		'petugas_kearsipan':
			pass
		'petugas_survey':
			pass
		'petugas_keuangan':
			pass
		'investor':
			pass

func _on_btn_pendapatan_pressed():
	setPageInfo(["Pendapatan", "Halaman pendapatan untuk "+role])
	match user:
		'petugas_kearsipan':
			pass
		'petugas_keuangan':
			pass

func _on_btn_investasi_pressed():
	setPageInfo(["Investasi", "Halaman investasi untuk "+role])
	match user:
		'investor':
			pass
		'petugas_keuangan':
			pass

func _on_btn_laporan_pressed():
	setPageInfo(["Laporan", "Tinjau lapran pendapatan dari pengusaha"])
	pass # Replace with function body.

func _on_btn_bidangUsaha_pressed():
	setPageInfo(["Bidang Usaha", "Kelola bidang usaha perikanan"])
	pass # Replace with function body.

func _on_btn_periodeIkan_pressed():
	setPageInfo(["Periode Ikan", "Kebutuhan waktu untuk panen berdasar jenis ikan"])
	pass # Replace with function body.

func _on_btn_transfer_pressed():
	setPageInfo(["Transfer", "Tinjau transfer dan keuangan investasi"])
	pass # Replace with function body.

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
