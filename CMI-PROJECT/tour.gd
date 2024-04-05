extends StaticBody2D

@onready var time = $Cooldown
@onready var tower = $Towershape
@onready var add_button = self.get_node("../addTower")
@onready var level = self.get_node("/root/draft") #REMPLACER DRAFT PAR LEVEL UNE FOIS LE PROJET FINI

var type = 1
var ennemy_in = []
var ennemy_target
var damage = 10
var created = false

func _ready():
	pass

func _process(delta):
	if ennemy_in and self.visible:
		ennemy_target = ennemy_in[0]
		tower.look_at(ennemy_target.global_position)
		if time.is_stopped():
			shoot_the_target(ennemy_target)
			time.start()
		
	if created:
		if level.gold < 60:
			add_button.disabled = true
		
		if level.gold >= 60:
			add_button.disabled = false
			add_button.text = "UP"

func _on_area_2d_area_entered(area):
	if self.visible:
		if area.is_in_group("ennemy"):
			print("Ennemy in the area")
			ennemy_in.append(area)

func _on_area_2d_area_exited(area):
	if self.visible:
		if area.is_in_group("ennemy"):
			print("Ennemy out of the area")
			ennemy_in.erase(area)

func _on_add_tower_pressed():
	self.show()
	if created:
		if type == 1:
			time.wait_time = 0.1
			level.gold -= 60
			
	if add_button and created == false:
		add_button.disabled = true
		add_button.position.y += 30
		created = true

func shoot_the_target(area):
	if self.visible:
		var bullet_scene = load("res://bullet.tscn")
		var bullet = bullet_scene.instantiate()
		bullet.target = ennemy_target
		bullet.damage = damage
		self.add_child(bullet)
