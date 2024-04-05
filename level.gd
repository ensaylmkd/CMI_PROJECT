extends Node2D
# Ce script est utilisé par le noeud de la scene "level"

# Le @export fait que cette variable sera affichée et éditable depuis l'inspecteur du noeud "level" dans Godot
# @export var niveau: int = 1 # Défini le niveau en cours ((pour l'instant en comm car jsp si on fait des nv ou juste un truc infini avec un record))
@export var enemy: PackedScene

# @onready = dès que le script est chargé, la variable est chargée
# $NAME = lien vers un différent noeud grace au chemin nécessaire pour y parvenir depuis le noeud auquel ce script est lié
@onready var path = $Path2D
@onready var follow = $Path2D/enemy
@onready var nb_enemies = 0

@export var gold = 0
var wave = 0 # Numéro de vague, va influencer le nb d'ennemis et leur niveau
signal finish_spawn
var started = false
var enemies_wave = {"1":0,"2":0,"3":0,"4":0,"5":0,}

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
	if self.get_node("Path2D").get_children(false) == [] and started:
		started = false
		await get_tree().create_timer(2).timeout
		next_wave()

func next_wave():
	await get_tree().create_timer(1).timeout
	nb_enemies += 6
	var wave_data = retriver_wave_data()
	spawn_enemies(wave_data)
	await finish_spawn
	started = true

func retriver_wave_data():
	var wave_data = []
	var lvl_enemy_max = nb_enemies%5
	
	for i in range(nb_enemies):
		wave_data.append(["enemy", randf_range(0.2,0.5), randi_range(0,lvl_enemy_max)])
	wave += 1
	return wave_data

func spawn_enemies(wave_data):
	for i in wave_data:
		var new_enemy = enemy.instantiate()
		new_enemy.type = i[2]+1
		self.get_node("Path2D").add_child(new_enemy, true)
		await get_tree().create_timer(i[1]).timeout
	emit_signal("finish_spawn")

func add_gold(g):
	gold += g
	print(gold)
