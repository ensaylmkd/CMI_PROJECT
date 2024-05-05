extends Control

func resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")
	self.visible = false
	
func pause():
	get_tree().paused = true
	$AnimationPlayer.play("blur")
	self.visible = true

func _ready():
	$AnimationPlayer.play("reset")
	self.visible = false

func testPause():
	if Input.is_action_just_pressed("Pause") and !get_tree().paused:
		pause()
	elif Input.is_action_just_pressed("Pause") and get_tree().paused:
		resume()

func _on_resume_pressed():
	button_menu_pressed()
	resume()
	
func _on_restart_pressed():
	button_menu_pressed()
	resume()
	get_tree().reload_current_scene()

func _on_quit_pressed():
	button_menu_pressed()
	get_tree().quit()

func _process(delta):
	testPause()

func button_menu_pressed():
	$sfx.play()
	await $sfx.finished

func _on_pausebutton_pressed():
		pause()
