extends Node2D
# Ce script est utilisé par le noeud de la scene "level"

# Le @export fait que cette variable sera affichée et éditable depuis l'inspecteur du noeud "level" dans Godot
# @export var niveau: int = 1 # Défini le niveau en cours ((pour l'instant en comm car jsp si on fait des nv ou juste un truc infini avec un record))
@export var enemy: PackedScene

# @onready = dès que le script est chargé, la variable est chargée
# $NAME = lien vers un différent noeud grace au chemin nécessaire pour y parvenir depuis le noeud auquel ce script est lié
@onready var path = $Path2D
@onready var nb_enemies = 0
@onready var hp = 100
@onready var healthbar = $Interface/HealthBar
@onready var goldcount = $Interface/GoldShow/Label

@export var gold = 45
var wave = 1 # Numéro de vague, va influencer le nb d'ennemis et leur niveau
signal finish_spawn
var started = false

# La fonction _ready() est lue dès que le noeud qui est accroché à ce script est dans la "current scene"
# Cette fonction ne sera lue qu'une seule fois (à part si elle est rappelée)
func _ready():
	$Interface/Label/AnimationPlayer.play("RESET")
	healthbar.max_value = hp
	healthbar.value = hp
	goldcount.text = str(gold)
	next_wave()

# Cette fonction est lue en boucle tant que le noeud à qui le script est lié est dans la "current scene"
func _process(_delta):
	if self.get_node("Path2D").get_children(false) == [] and started:
		started = false
		
#		for sc in ["PosTow1", "PosTow2", "PosTow3"]:
#			for i in self.get_node(sc + "/tower/bullets").get_children(false):
#				i.queue_free()
		
		await get_tree().create_timer(2).timeout
		next_wave()

func next_wave():
	$Interface/Label.text = "WAVE " + str(wave)
	$Interface/Label/AnimationPlayer.play("new_wave")
	await not $Interface/Label/AnimationPlayer.is_playing()
	await get_tree().create_timer(1).timeout
	nb_enemies += 5
	var wave_data = retriver_wave_data()
	spawn_enemies(wave_data)
	await finish_spawn
	started = true

func retriver_wave_data():
	var wave_data = []
	var mobs_left = nb_enemies
	if wave >= 15:
		for i in range(randi_range(mobs_left/20,mobs_left/5)):
			wave_data.append(["enemy", randf_range(0.2,0.5),4])
			mobs_left -= 1
	if wave >= 10:
		for i in range(randi_range(mobs_left/10,mobs_left/5)):
			wave_data.append(["enemy", randf_range(0.2,0.5),3])
			mobs_left -= 1
	
	if wave >= 6:
		for i in range(randi_range(mobs_left/5,mobs_left/3)):
			wave_data.append(["enemy", randf_range(0.2,0.5),2])
			mobs_left -= 1
	
	if wave > 2:
		for i in range(randi_range(mobs_left/4,mobs_left/2)):
			wave_data.append(["enemy", randf_range(0.2,0.5),1])
			mobs_left -= 1
	
	for i in range(mobs_left):
			wave_data.append(["enemy", randf_range(0.2,0.5),0])

	wave += 1
	wave_data.shuffle()
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
	goldcount.text = str(gold)
	
func damage_base(damage):
	$hurtsound.play()
	hp -= damage
	healthbar.value = hp
	if hp <= 0:
		$Interface/busted.visible = true
		get_tree().paused = true
		$Interface/busted/AnimationPlayer.play("busted")
		await get_tree().create_timer(1).timeout
		$Interface/busted/AnimationPlayer.play("idle")
		await get_tree().create_timer(5).timeout
		get_tree().paused = false
		$Interface/busted.visible = false
		get_tree().change_scene_to_file("res://control.tscn")
		
func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_COMMA:
			add_gold(9999999999)
		if event.pressed and event.keycode == KEY_SPACE:
			damage_base(9999)
