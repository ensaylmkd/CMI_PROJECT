extends StaticBody2D
# Ceci est le script qui est appliqué à chacune des tours

# Chaque tour aura une variable personnalisée pour informer quelle type de tour elle est 
@export var type: int = 0 # 0 = Niveau de départ <=> la tour n'est pas encore construite

# (en gdscript, on déclare une fonction avec func et une variable avec var)

# La fonction _ready() est lue dès que le noeud qui est accroché à ce script est dans la "current scene"
# On peut la comparer à la fonction main() en language C
# Cette fonction ne sera lue qu'une seule fois (à part si elle est rappelée)
func _ready():
	pass 


# Cette fonction est lue en boucle tant que le noeud à qui le script est lié est dans la "current scene"
func _process(delta):
	pass


func _on_area_2d_area_entered(area):
	print("Ennemy in the area")


func _on_area_2d_area_exited(area):
	print("Ennemy out of the area")
