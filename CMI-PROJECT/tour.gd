extends StaticBody2D

@onready var time = $Cooldown
@onready var tower = $Towershape
@onready var add_button = self.get_node("../addTower")

var ennemy_in = []
var ennemy_target
var damage = 10

func _ready():
	pass

func _process(delta):
	if ennemy_in and self.visible:
		ennemy_target = ennemy_in[0]
		tower.look_at(ennemy_target.global_position)
		if time.is_stopped():
			shoot_the_target(ennemy_target)
			time.start()
		
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
	if add_button:
		add_button.disabled = true
		add_button.position.y += 30

func shoot_the_target(area):
	if self.visible:
		var bullet_scene = load("res://bullet.tscn")
		var bullet = bullet_scene.instantiate()
		bullet.target = ennemy_target
		bullet.damage = damage
		self.add_child(bullet)
