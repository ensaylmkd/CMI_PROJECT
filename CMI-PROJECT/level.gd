extends Node2D
# Ce script est utilisé par le noeud de la scene "level"

# Le @export fait que cette variable sera affichée et éditable depuis l'inspecteur du noeud "level" dans Godot
# @export var niveau: int = 1 # Défini le niveau en cours ((pour l'instant en comm car jsp si on fait des nv ou juste un truc infini avec un record))

# @onready = dès que le script est chargé, la variable est chargée
# $NAME = lien vers un différent noeud grace au chemin nécessaire pour y parvenir depuis le noeud auquel ce script est lié
@onready var path = $Path2D
@onready var follow = $Path2D/PathFollow2D

var vague = 0 # Numéro de vague, va influencer le nb d'ennemis et leur niveau


# La fonction _ready() est lue dès que le noeud qui est accroché à ce script est dans la "current scene"
# On peut la comparer à la fonction main() en language C
# Cette fonction ne sera lue qu'une seule fois (à part si elle est rappelée)
func _ready():
	pass


# Cette fonction est lue en boucle tant que le noeud à qui le script est lié est dans la "current scene"
func _process(delta):
	pass


func next_vague():
	pass
