extends CharacterBody2D

@export var lvl = 1

@onready var speed = 300
@onready var atk_zone = $Area2D/AreaCollision
@onready var collision = $BodyCollision
@onready var anim = $AnimatedSprite2D

func _physics_process(delta):
	move_and_slide()
