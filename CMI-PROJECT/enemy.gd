extends PathFollow2D

@onready var types = [{"type":1, "speed":0.01, "health":10, "gold":10}, #Storm Blancs
					{"type":2, "speed":0.02, "health":20, "gold":15}, #Storm Noirs
					{"type":3, "speed":0.025, "health":30, "gold":20}, #Storm Rouges
					{"type":4, "speed":0.30, "health":30, "gold":30}, #Drones
					{"type":5, "speed":0.03, "health":60, "gold":50}] #Strickers
@export var type: int

@onready var sprite = $AnimatedSprite2D
@onready var anim = $AnimationPlayer
@onready var speed: float
@onready var health: int
@onready var gold: int
#
#@onready var skill_used = false
#@onready var old_hp: int
#@onready var old_speed: int

func _ready():
	anim.play("static")
	self.h_offset = randf_range(-10, 10)
	self.v_offset = randf_range(-10, 20)
	sprite.play("type"+str(type))
	speed = types[type-1].speed
	health = types[type-1].health
	gold = types[type-1].gold

func _process(delta):
	if progress_ratio == 1 :
		queue_free()
	elif health <=0 :
		self.get_node("/root/draft").add_gold(gold)
		queue_free()
#	skill(type)

func _physics_process(delta):
	if anim.is_playing():
		move(delta)

func move(delta):
	anim.play("move")
	anim.advance(delta*speed)

#func skill(type):
#	if type == 1: 
#		pass
#	elif type == 2: 
#		pass
#	elif type == 3: 
#		pass
#	elif type == 4: #Shield
#		if skill_used == false:
#			await get_tree().create_timer(types[type-1].countdown).timeout
#			old_hp = health
#			print(health)
#			health += 20
#			sprite.set_modulate(Color(1, 0, 1, 1))
#			skill_used = true
#		if old_hp > health and skill_used == true:
#			await get_tree().create_timer(types[type-1].countdown).timeout
#			print(old_hp)
#			print(health)
#			sprite.set_modulate(Color(1, 1, 1, 1))
#			skill_used = false
#	elif type == 5: #Front Dash
#		pass
