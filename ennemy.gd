extends PathFollow2D

@export var lvl = 1

@onready var speed = 0.1
@onready var atk_zone = $Area2D/AreaCollision
@onready var anim = $AnimatedSprite2D

func _process(delta):
	progress_ratio += speed * delta

#func move(delta):
#	$AnimationPlayer.play("move")
#	$AnimationPlayer.advance(delta*speed)
