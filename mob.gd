extends PathFollow2D


@export var health = 100
@export var speed = 50
@export var damage = 10
@export var loot = 5


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	progress_ratio += (speed * delta)/1000
	if progress_ratio == 1 :
		pass #do damage and depop
	if health <= 0 :
		pass # depop
	
	
