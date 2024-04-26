extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/play.grab_focus()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_play_pressed():
	
	get_tree().change_scene_to_file("res://level.tscn")
	pass # Replace with function body.


func _on_options_pressed():
	#get_tree().change_scene_to_file("res://options.tscn")
	pass # Replace with function body.


func _on_quit_pressed():
	get_tree().quit()

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_SPACE:
			get_tree().change_scene_to_file("res://level.tscn")
