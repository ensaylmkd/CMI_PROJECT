extends Node2D

var target : Area2D
var direction : Vector2
@onready var bullet = $bulletbody


func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	direction = (bullet.global_position - target.global.position).normalized()
	print(direction)
	
