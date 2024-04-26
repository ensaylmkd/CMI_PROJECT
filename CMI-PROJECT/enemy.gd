extends PathFollow2D

@export var type: int

@onready var types = [
	{"type":1, "speed":0.01, "health":10, "gold":10, "damage":5},
	{"type":2, "speed":0.02, "health":20, "gold":15, "damage":7},
	{"type":3, "speed":0.025, "health":30, "gold":20, "damage":10},
	{"type":4, "speed":0.30, "health":30, "gold":30, "damage":15},
	{"type":5, "speed":0.03, "health":60, "gold":50, "damage":20}
]


@onready var sprite = $AnimatedSprite2D
@onready var anim = $AnimationPlayer
@onready var healthbar = $healthbar

@onready var speed: float
@onready var max_health: int
@onready var health: int
@onready var damage: int
@onready var gold: int

func _ready():
	anim.play("static")
	self.h_offset = randf_range(-10, 10)
	self.v_offset = randf_range(-10, 20)
	sprite.play("type"+str(type))
	
	speed = types[type-1].speed
	max_health = types[type-1].health
	health = max_health
	damage = types[type-1].damage
	gold = types[type-1].gold
	healthbar.max_value = max_health
	

func _process(delta):
	update_health_bar()
	if progress_ratio == 1:
		self.get_node("/root/Level").damage_base(damage)
		queue_free()
	elif health <= 0:
		self.get_node("/root/Level").add_gold(gold)
		queue_free()

func _physics_process(delta):
	if anim.is_playing():
		move(delta)

func move(delta):
	anim.play("move")
	anim.advance(delta*speed)
	
func update_health_bar():
	if max_health != health:
		if not healthbar.visible:
			healthbar.visible = true
		healthbar.value = health
	elif healthbar.visible:
		healthbar.visible = false
	

