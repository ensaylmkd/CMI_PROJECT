extends Node2D

@export var damage = 10
@export var price = 10
@onready var towerBody = $Towerbody
var targetmob
var mobInRange=[]


func _physics_process(delta):
	if mobInRange:
		targetmob = mobInRange[0]
		towerBody.look_at(targetmob.position) # don't work doit regarde le mob 

func _on_range_area_area_entered(area):
	print("ennemie detecter")
	if area.is_in_group("Mob"):
		mobInRange.append(area)

func _on_range_area_area_exited(area):
	print("ennemie perdu")
	if area.is_in_group("Mob"):
		mobInRange.erase(area)
