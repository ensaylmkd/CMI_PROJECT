extends Node2D

var types =[
	"res://graphics/Tower/bullet.png",
	"res://graphics/Tower/bullet_damage.png",
	"res://graphics/Tower/bullet_speed.png",
	"res://graphics/Tower/bullet_range.png",
]
@onready var bullet = $Bullet

var bullet_type : int
var speed := 20
var damage : int
var target : Area2D
var direction : Vector2


func _ready():
	bullet.texture = load(types[bullet_type])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if target!= null: 
		direction = (target.global_position - self.global_position )
		bullet.look_at(target.global_position)
		self.global_position+=direction*speed*delta 
		
	else:
		self.global_position+=direction*speed*delta 
	

func _on_area_2d_area_entered(area):
	if area.is_in_group("enemy"):
		area.get_parent().health -= damage
		queue_free()
