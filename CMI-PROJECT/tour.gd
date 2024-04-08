extends StaticBody2D

@onready var time = $Cooldown
@onready var tower = $Towershape
@onready var area_range = $Area2D/ShootArea 
@onready var level = self.get_node("/root/draft") #REMPLACER DRAFT PAR LEVEL UNE FOIS LE PROJET FINI

var enemy_in = []
var enemy_target

var damage

var created = false

func _ready():
	time.wait_time = 1.5
	damage = 10
	area_range.shape.radius = 100
	
func _process(delta):
	if enemy_in :
		enemy_target = enemy_in[0]
		tower.look_at(enemy_target.global_position)
		if time.is_stopped():
			shoot_the_target(enemy_target)
			time.start()


func _on_area_2d_area_entered(area):
	if area.is_in_group("enemy"):
		print("enemy in the area")
		enemy_in.append(area)

func _on_area_2d_area_exited(area):
	if area.is_in_group("enemy"):
		print("enemy out of the area")
		enemy_in.erase(area)

func shoot_the_target(area):
	var bullet_scene = load("res://bullet.tscn")
	var bullet = bullet_scene.instantiate()
	bullet.target = enemy_target
	bullet.damage = damage
	$bullets.add_child(bullet)
	
func reset_bullets():
	for i in $bullets.get_children(false):
		i.queue_free()

func upgrade_speed():
	time.wait_time -=0.3 
	
func upgrade_damage():
	damage += 5

func upgrade_range():
	area_range.shape.radius += 20
