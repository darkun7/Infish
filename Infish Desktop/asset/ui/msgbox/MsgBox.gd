extends Control

func _ready():
	pass # Replace with function body.

func _process(delta):
	$box/progresbar.value = $timer.time_left

func _on_timer_timeout():
	close()

func open(type, title, message):
	var word = (message.split(' ', false).size())*1.2
	match type:
		"SUKSES":
			$box.color = "00ffb1"
		"INFO":
			$box.color = "00fff9"
		"ERROR":
			$box.color = "ff9c9c"
	$box/head/text.text = title
	$box/message.text = message
	$timer.wait_time = word
	$timer.start()
	$box/progresbar.min_value = 0
	$box/progresbar.max_value = word
	$animation.play("FadeIn")
	$".".visible = true
	
func close():
	$animation.play("FadeOut")

func _on_close_button():
	close()

func _on_animation_finished(anim_name):
	if anim_name == "FadeOut":
		$timer.wait_time = 0
		$timer.stop()
		$".".visible = false
