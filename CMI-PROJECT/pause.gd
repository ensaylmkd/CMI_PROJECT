extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_continue_pressed():
	get_tree().paused = false
	self.visible = false
	
func _on_exit_pressed():
	get_tree().paused = false
	self.visible = false
	get_tree().change_scene_to_file("res://control.tscn")

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_ESCAPE:
			get_tree().paused = not get_tree().paused
			self.visible = not self.visible
			
			if self.visible and $VBoxContainer/continue.has_focus():
				$VBoxContainer/continue.grab_focus()
