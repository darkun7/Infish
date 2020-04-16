extends Control

var fullscreen_mode = true

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


