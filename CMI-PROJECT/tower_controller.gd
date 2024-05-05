extends Button

@onready var level = self.get_node("/root/Level")

@export var cost = 30
var created = false

func _on_pressed():
	if cost <= level.gold:
		$AudioStreamPlayer.play()
		var tower_scene = load("res://tourDraft.tscn")
		var tower = tower_scene.instantiate()
		self.add_child(tower)
		level.add_gold(-cost)
		$button_visual.visible = false
		created = true
