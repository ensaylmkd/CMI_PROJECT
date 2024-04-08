extends Node2D

var speed = 30
var damage 
var target : Area2D
var direction : Vector2
@onready var bullet = $bulletbody

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if target!= null: 
		direction = (target.global_position - self.global_position )
		$bulletbody.look_at(target.global_position)
		self.global_position+=direction*speed*delta 
	else:
		self.global_position+=direction*speed*delta 
	

func _on_area_2d_area_entered(area):
	if area.is_in_group("enemy"):
		print("hit")
		area.get_parent().health -= damage
		queue_free()
