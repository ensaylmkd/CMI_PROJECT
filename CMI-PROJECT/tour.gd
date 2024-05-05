extends StaticBody2D

@onready var time = $Cooldown
@onready var tower = $Towershape
@onready var area_range = $Area2D/ShootArea 
@onready var level = self.get_node("/root/Level") #REMPLACER DRAFT PAR LEVEL UNE FOIS LE PROJET FINI

@onready var upgrade_control = $upgrader_sys/upgrade_control
@onready var label_cost = $upgrader_sys/upgrade_control/upgrade_cost

@onready var label_damage = $upgrader_sys/upgrade_control/upgrade_damage/button_visual/Label
@onready var button_damage = $upgrader_sys/upgrade_control/upgrade_damage/button_visual/upgrade_damage

@onready var label_speed = $upgrader_sys/upgrade_control/upgrade_firerate/button_visual/Label
@onready var button_speed = $upgrader_sys/upgrade_control/upgrade_firerate/button_visual/upgrade_firerate

@onready var label_range = $upgrader_sys/upgrade_control/upgrade_range/button_visual/Label
@onready var button_range = $upgrader_sys/upgrade_control/upgrade_range/button_visual/upgrade_range


var enemy_in = []
var enemy_target
var type_bullet = 0
 
var damage

var lvl_counter = 1
var lvl_damage = 1
var lvl_firerate = 1
var lvl_range = 1

var big_upgraded = false
var created = false
var next_upgrade = 30
signal upgraded

func _ready():
	time.wait_time = 1.5
	damage = 10
	area_range.shape.radius = 100
	
func _process(delta):
	if enemy_in :
		enemy_target = enemy_in[0]
		if time.is_stopped():
			shoot_the_target(enemy_target)
			time.start()
	if lvl_counter < 13:
		$upgrader_sys/upgrade_notifier.visible = next_upgrade <= level.gold
	else:
		$upgrader_sys/upgrade_notifier.visible = false
	
	
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
	bullet.bullet_type = type_bullet 
	$bullets.add_child(bullet)

#//////////// opti sys ///////////////
func reset_bullets():
	for i in $bullets.get_children(false):
		i.queue_free()


# //////////// boutons d'upgrades /////////////////
func _on_upgrade_notifier_pressed():
	upgrade_control.visible = true
	label_cost.text="cost: "+str(next_upgrade)
	await upgraded
	upgrade_control.visible = false

func _on_upgrade_damage_pressed():
	button_upgrade_pressed()
	emit_signal("upgraded")
	
	if lvl_damage < 4 :	
		lvl_damage += 1
		label_damage.text ="damage: lvl "+str(lvl_damage)
		damage += 5
	else:
		if not big_upgraded :
			$Towerbase.texture = load("res://graphics/Tower/towerdamage.png")	
			damage += 50
			big_upgraded = true
			type_bullet = 1
		label_damage.text ="damage: lvl MAX"
		button_damage.visible = false
		
	level.add_gold(-next_upgrade)
	lvl_counter += 1
	next_upgrade += int(lvl_counter * 11)
	
func _on_upgrade_firerate_pressed():
	button_upgrade_pressed()
	emit_signal("upgraded")
	
	if lvl_firerate < 4 :	
		lvl_firerate += 1
		label_speed.text ="speed: lvl "+str(lvl_firerate)
		time.wait_time -= 0.2
	else:
		if not big_upgraded :
			$Towerbase.texture = load("res://graphics/Tower/towerspeed.png")	
			time.wait_time = 0.35
			big_upgraded = true
			type_bullet = 2	
		label_speed.text ="speed: lvl MAX"
		button_speed.visible = false
	
	level.add_gold(-next_upgrade)
	lvl_counter += 1
	next_upgrade += int(lvl_counter * 10)
	
func _on_upgrade_range_pressed():
	button_upgrade_pressed()
	emit_signal("upgraded")
	
	if lvl_range < 4 :	
		lvl_range += 1
		label_range.text ="range: lvl "+str(lvl_range)
		area_range.shape.radius += 20
	else:
		if not big_upgraded : 
			$Towerbase.texture = load("res://graphics/Tower/towerrange.png")
			area_range.shape.radius += 300
			time.wait_time += 0.4
			damage += 100
			big_upgraded = true
			type_bullet = 3
		label_range.text ="range: lvl MAX"
		button_range.visible = false
	
	level.add_gold(-next_upgrade)
	lvl_counter += 1
	next_upgrade += int(lvl_counter*10)
	print(lvl_counter)

func button_upgrade_pressed():
	$sfx.play()

func _on_upgrade_cancel_pressed():
	$cancel.play()
	emit_signal("upgraded")
