extends PathFollow2D

@export var lvl = 1

@onready var speed = 0.1
@onready var health = 50
var damage = 10
@onready var atk_zone = $Area2D/AreaCollision
@onready var anim = $AnimatedSprite2D

func _process(delta):
	progress_ratio += speed * delta
	if progress_ratio == 1 :
		pass
	elif health <=0 : 
		queue_free()
		
		

		
		
