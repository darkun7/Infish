extends Control

var fullscreen_mode = true
var user_setting = false

signal user_setting

func _ready():
	#OS.window_borderless = true
	pass

# ========= Events ========
func _on_quit_button_up():
	get_tree().quit()

func _on_fullscreen_button_up():
	fullscreen(fullscreen_mode)
	fullscreen_mode = !fullscreen_mode

func _on_minimize_button_up():
	OS.window_minimized = true

# ========= Methods ========
func fullscreen(type : bool = true):
	OS.window_fullscreen = type
	if (type):
		#OS.window_borderless = false
		$Control/fullscreen.set("texture_normal", load("res://asset/ui/icon/navigator/fullscreen-0.png"))
	else:
		#OS.window_borderless = true
		$Control/fullscreen.set("texture_normal", load("res://asset/ui/icon/navigator/fullscreen-1.png"))
	pass



func _on_user_setting_button_up():
	if(!user_setting):
		$Control/user_setting/user_panel.visible = true
	else:
		$Control/user_setting/user_panel.visible = false
	user_setting = !user_setting

func _on_btn_account_button_up():
	emit_signal("user_setting")
	_on_user_setting_button_up()
	#

func _on_btn_logout_button_up():
	_on_user_setting_button_up()
	get_tree().change_scene("res://src/view/Auth.tscn")



