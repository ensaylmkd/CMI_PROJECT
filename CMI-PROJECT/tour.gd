extends StaticBody2D

@onready var time = $Cooldown
@onready var tower = $Towershape
@onready var area_range = $Area2D/ShootArea 
@onready var level = self.get_node("/root/draft") #REMPLACER DRAFT PAR LEVEL UNE FOIS LE PROJET FINI
@onready var upgrade_control = $upgrader_sys/upgrade_control

var enemy_in = []
var enemy_target

var damage

var lvl_damage = 1
var lvl_firerate = 1
var lvl_range = 1

var created = false
var next_upgrade = 30
signal upgraded

func _ready():
	time.wait_time = 1.5
	damage = 20
	area_range.shape.radius = 100
	
func _process(delta):
	if enemy_in :
		enemy_target = enemy_in[0]
		tower.look_at(enemy_target.global_position)
		if time.is_stopped():
			shoot_the_target(enemy_target)
			time.start()
	
	$upgrader_sys/upgrade_notifier.visible = next_upgrade <= level.gold 
	
#////////////// detection des ennemies//////////////////
func _on_area_2d_area_entered(area):
	if area.is_in_group("enemy"):
		enemy_in.append(area)

func _on_area_2d_area_exited(area):
	if area.is_in_group("enemy"):
		enemy_in.erase(area)

func shoot_the_target(area):
	var bullet_scene = load("res://bullet.tscn")
	var bullet = bullet_scene.instantiate()
	bullet.target = enemy_target
	bullet.damage = damage
	$bullets.add_child(bullet)

#//////////// opti sys ///////////////
func reset_bullets():
	for i in $bullets.get_children(false):
		i.queue_free()


# //////////// boutons d'upgrades /////////////////
func _on_upgrade_notifier_pressed():
		upgrade_control.visible = true
		await upgraded
		upgrade_control.visible = false

func _on_upgrade_damage_pressed():
	emit_signal("upgraded")
	
	lvl_damage += 1
	damage += 5
	level.gold -= next_upgrade
	next_upgrade += 10
	
func _on_upgrade_firerate_pressed():
	emit_signal("upgraded")
	
	lvl_firerate += 1
	time.wait_time -=0.3 
	level.gold -= next_upgrade
	next_upgrade += 10
	
func _on_upgrade_range_pressed():
	emit_signal("upgraded")
	
	lvl_damage += 1
	area_range.shape.radius += 20
	level.gold -= next_upgrade
	next_upgrade += 10

func _on_upgrade_cancel_pressed():
	emit_signal("upgraded")
