extends PathFollow2D

@onready var types = [{"type":1, "speed":0.01, "health":10, "gold":10},
					{"type":2, "speed":0.02, "health":20, "gold":15},
					{"type":3, "speed":0.025, "health":30, "gold":20},
					{"type":4, "speed":0.30, "health":30, "gold":30},
					{"type":5, "speed":0.03, "health":60, "gold":50}]
@export var type: int

@onready var sprite = $AnimatedSprite2D
@onready var anim = $AnimationPlayer
@onready var speed: float
@onready var health: int
@onready var gold: int

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
		print(self.get_node("/root/draft").gold)
		queue_free()

func _physics_process(delta):
	if anim.is_playing():
		move(delta)

func move(delta):
	anim.play("move")
	anim.advance(delta*speed)
