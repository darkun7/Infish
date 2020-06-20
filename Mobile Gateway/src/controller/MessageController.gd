extends Control

onready var DB        = $DBconnection
onready var Handler   = load("res://src/lib/InputHandler.gd").new()
onready var gw        = load("res://src/model/sms.gd").new()
onready var message   = $messageBox/msg

var chat_base         = load('res://assets/bubbleChat.tscn')   
var chat_sys_style    = load('res://assets/systemBubble.stylebox')

var tf_toggle = false
var ph_toggle = false
var noHp

func _ready():
	message.text = "Tulis Pesan"
	noHp = $header/sender/phoneNumber.text
	#DB.handleRequest("POST", Helper.insert("users", attr, inputs))

func _process(delta):
	if(delta):
		var timeDict = OS.get_time()
		var hour     = str(timeDict.hour)
		var minute   = timeDict.minute
		if(minute<10):
			minute = str(minute)
			minute ='0'+minute
		$indicator/container/currentTime.text = hour+':'+str(minute)

# ========= Numeric Input  =========
func _on_phoneNumber_text_changed(new_text):
	var new = new_text[-1]
	if !(new.is_valid_integer()):
		$header/sender/phoneNumber.set('text', noHp)
		$header/sender/phoneNumber.set_cursor_position(noHp.length())
	else:
		noHp = new_text

# ========= Toogle Menu  =========
func _on_btnTextFormat_button_up():
	if(tf_toggle):
		$formatOption.hide()
	else:
		$formatOption.show()
	tf_toggle = !tf_toggle

func _on_btn_PhoneSetting_button_up():
	if(ph_toggle):
		$header/receiver.hide()
		$header/sender.show()
	else:
		$header/receiver.show()
		$header/sender.hide()
	ph_toggle = !ph_toggle

func _on_tf_pendapatan_pressed():
	message.text = "PENDAPATAN nominal jenis_ikan berat"
	_on_btnTextFormat_button_up()

func _on_tf_klaim_pressed():
	message.text = "KLAIM nominal"
	_on_btnTextFormat_button_up()

func _on_tf_pengeluaran_pressed():
	message.text = "PENGELUARAN nominal keterangan"
	_on_btnTextFormat_button_up()

func _on_tf_setoran_pressed():
	message.text = "SETOR nominal kode_transaksi"
	_on_btnTextFormat_button_up()

func _on_tf_penjualan_pressed():
	message.text = "PENJUALAN bulan"
	_on_btnTextFormat_button_up()



# ========= Send Message =========
func _on_btnSend_button_up():
	var pesan = message.text
	if(Handler.validate(pesan)):
		userSendMsg(pesan)
		systemMsg(gw._gw_in_infish(pesan, noHp))

func userSendMsg(pesan):
	var chatLog = get_node("msgLog/scroll/msgContainer")
	var chat = chat_base.instance()
	chat.text = pesan
	chat.set('align',2)
	chatLog.add_child(chat, true)
	message.text = "Tulis Pesan"

func systemMsg(pesan):
	var chatLog = get_node("msgLog/scroll/msgContainer")
	var chat = chat_base.instance()
	chat.set('custom_styles/normal', chat_sys_style)
	chat.text = pesan
	chat.set('align',0)
	chatLog.add_child(chat, true)







