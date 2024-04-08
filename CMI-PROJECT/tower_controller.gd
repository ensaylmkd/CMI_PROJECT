extends Button

@onready var created = false
@onready var level = self.get_node("/root/draft")

var lvl_speed = 1
var lvl_damage = 1
var lvl_range = 1

# amelioration: firerate , range , damage 
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if created:
		if level.gold < 60: # pas assez de gold
			self.disabled = true
		if level.gold >= 60: # assez de gold
			self.disabled = false
			self.text = "UP"

func _on_pressed():
	if not created: # creation de tour de base
		var tower_scene = load("res://tourDraft.tscn")
		var tower = tower_scene.instantiate()
		self.add_child(tower)
		created = true
	else:	# amelioration de la tour
		self.get_children()[0].upgrade_range()
