extends StaticBody2D
# Ceci est le script qui est appliqué à chacune des tours

# Chaque tour aura une variable personnalisée pour informer quelle type de tour elle est 
@export var type: int = 0 # 0 = Niveau de départ <=> la tour n'est pas encore construite
@onready var time = $Cooldown
@onready var tower = $Towershape

var ennemy_in = []
var ennemy_target

# (en gdscript, on déclare une fonction avec func et une variable avec var)

# La fonction _ready() est lue dès que le noeud qui est accroché à ce script est dans la "current scene"
# On peut la comparer à la fonction main() en language C
# Cette fonction ne sera lue qu'une seule fois (à part si elle est rappelée)
func _ready():
	self.show()


# Cette fonction est lue en boucle tant que le noeud à qui le script est lié est dans la "current scene"
func _process(delta):
	if ennemy_in and self.visible:
		ennemy_target = ennemy_in[0]
		tower.look_at(ennemy_target.global_position)
		if time.is_stopped():
			shoot_the_target(ennemy_target)
			time.start()
		
func _on_area_2d_area_entered(area):
	if self.visible:
		if area.is_in_group("ennemy"):
			print("Ennemy in the area")
			ennemy_in.append(area)

func _on_area_2d_area_exited(area):
	if self.visible:
		if area.is_in_group("ennemy"):
			print("Ennemy out of the area")
			ennemy_in.erase(area)

func _on_add_tower_pressed():
	self.show()
	if self.get_node("../addTower"):
		self.get_node("../addTower").hide()
		

func shoot_the_target(area):
	var bullet_scene = load("res://bullet.tscn")
	var bullet = bullet_scene.instantiate()
	bullet.target = ennemy_target
	self.add_child(bullet)
