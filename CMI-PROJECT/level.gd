extends Node2D
# Ce script est utilisé par le noeud de la scene "level"

# Le @export fait que cette variable sera affichée et éditable depuis l'inspecteur du noeud "level" dans Godot
# @export var niveau: int = 1 # Défini le niveau en cours ((pour l'instant en comm car jsp si on fait des nv ou juste un truc infini avec un record))
@export var ennemy: PackedScene

# @onready = dès que le script est chargé, la variable est chargée
# $NAME = lien vers un différent noeud grace au chemin nécessaire pour y parvenir depuis le noeud auquel ce script est lié
@onready var path = $Path2D
@onready var follow = $Path2D/Ennemy
@onready var nb_ennemies = 0


var wave = 0 # Numéro de vague, va influencer le nb d'ennemis et leur niveau
signal finish_spawn

# La fonction _ready() est lue dès que le noeud qui est accroché à ce script est dans la "current scene"
# Cette fonction ne sera lue qu'une seule fois (à part si elle est rappelée)
func _ready():
	# Test d'avancer d'un ennemi
	#print(follow.get_progress_ratio())
	#$Path2D/AnimationPlayer.play("new_animation")
	next_wave()
	pass

# Cette fonction est lue en boucle tant que le noeud à qui le script est lié est dans la "current scene"
func _process(delta):
	#if follow.progress_ratio == 1:
	#	$Path2D/AnimationPlayer.play("new_animation")
	pass

func next_wave():
	await get_tree().create_timer(1).timeout
	nb_ennemies += 1
	var wave_data = retriver_wave_data()
	spawn_ennemies(wave_data)
	await finish_spawn
	await get_tree().create_timer(20).timeout
	for i in self.get_node("Path2D").get_children(false):
		i.queue_free()
	next_wave()

func retriver_wave_data():
	var wave_data = []
	for i in range(nb_ennemies):
		wave_data.append(["ennemy", randf_range(0.05,0.4)])
	wave += 1
	return wave_data

func spawn_ennemies(wave_data):
	for i in wave_data:
		var new_ennemy = ennemy.instantiate()
		self.get_node("Path2D").add_child(new_ennemy, true)
		await get_tree().create_timer(i[1]).timeout
	emit_signal("finish_spawn")
