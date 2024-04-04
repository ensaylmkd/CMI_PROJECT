extends PathFollow2D

@export var type = 1

@onready var speed = randf_range(0.001, 0.03)
@onready var anim = $AnimatedSprite2D
@onready var health = 50

func _ready():
	anim.play("static")
	self.h_offset = randf_range(-10, 10)
	self.v_offset = randf_range(-10, 20)

func _process(delta):
	if self.progress_ratio == 1 or health == 0:
		queue_free()

func _physics_process(delta):
	if anim.is_playing():
		move(delta)

func move(delta):
	anim.play("move")
	anim.advance(delta*speed)
