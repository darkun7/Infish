extends Control

onready var Handler = preload("res://src/lib/InputHandler.gd").new()
onready var btn_send   = $messageBox/btnSend
onready var btn_text   = $messageBox/btnTextFormat
onready var message    = $messageBox/msg

var chat_base = preload('res://assets/bubbleChat.tscn')   
var chat_sys_style  = load('res://assets/systemBubble.stylebox')

var timeDict = OS.get_time();
var hour = timeDict.hour;
var minute = timeDict.minute;

var tf_toggle = false

func _ready():
	$indicator/container/currentTime.text = str(hour)+':'+str(minute)
	message.text = "Tulis Pesan"

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_btnTextFormat_button_up():
	if(tf_toggle):
		$formatOption.hide()
	else:
		$formatOption.show()
	tf_toggle = !tf_toggle

func _on_tf_pendapatan_pressed():
	message.text = "PENDAPATAN nominal jenis_ikan berat"
	_on_btnTextFormat_button_up()


func _on_tf_pengeluaran_pressed():
	message.text = "PENGELUARAN nominal keterangan"
	_on_btnTextFormat_button_up()

func _on_tf_klaim_pressed():
	message.text = "KLAIM nominal"
	_on_btnTextFormat_button_up()

func _on_tf_setoran_pressed():
	message.text = "SETOR nominal kode_transaksi"
	_on_btnTextFormat_button_up()

func _on_btnSend_button_up():
	var pesan = message.text
	if(Handler.validate(pesan)):
		userSendMsg(pesan)
		systemMsg("Pesan Respon")
	
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
	print(chat.get('align'))
	chatLog.add_child(chat, true)