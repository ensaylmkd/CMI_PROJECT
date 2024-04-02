extends PathFollow2D

@export var type = 1

@onready var speed = randf_range(0.001, 0.03)
@onready var atk_zone = $Area2D/AreaCollision
@onready var anim = $AnimatedSprite2D

func _ready():
	$AnimationPlayer.play("static")

func _physics_process(delta):
	if $AnimationPlayer.is_playing():
		move(delta)

func move(delta):
	$AnimationPlayer.play("move")
	$AnimationPlayer.advance(delta*speed)
