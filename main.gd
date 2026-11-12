extends Node2D

@onready var bird = $Bird
@onready var spawn_timer = $SpawnTimer
@onready var label_pontos = $CanvasLayer/LabelPontos
@onready var label_gameover = $CanvasLayer/LabelGameOver
@onready var label_recorde = $CanvasLayer/LabelRecorde
@onready var som_point = $SomPoint
@onready var som_hit = $SomHit
var obstaculo_scene = preload("res://obstáculo.tscn")
var score = 0
var recorde = 0
var game_started = false
var game_over_ja = false
var jogando = false

func _ready():
	carregar_recorde()
	label_recorde.text = "Recorde: " + str(recorde)
	label_gameover.hide()
	label_pontos.text = "0"

func _input(event):
	if event is InputEventScreenTouch and event.pressed:
		if game_over_ja:
			get_tree().reload_current_scene()
			return
		elif not game_started:
			start_game()
			bird.flap()
		else:
			bird.flap()

func start_game():
	game_started = true
	jogando = true
	score = 0
	label_pontos.text = "0"
	spawn_timer.start()

func _on_spawn_timer_timeout():
	if not jogando:
		return
	var novo_obstaculo = obstaculo_scene.instantiate()
	novo_obstaculo.position = Vector2(600, randf_range(300, 400))
	add_child(novo_obstaculo)
	if novo_obstaculo.has_node("Ponto"):
		novo_obstaculo.get_node("Ponto").body_entered.connect(_on_ponto)
	

func _on_ponto(_body):
	score += 1
	label_pontos.text = str(score)
	som_point.play()

func carregar_recorde():
	if FileAccess.file_exists("user://recorde.save"):
		var arquivo = FileAccess.open("user://recorde.save", FileAccess.READ)
		recorde = arquivo.get_var()
		arquivo.close()

func salvar_recorde():
	var arquivo = FileAccess.open("user://recorde.save", FileAccess.WRITE)
	arquivo.store_var(recorde)
	arquivo.close()

func game_over():
	if game_over_ja:
		return
	game_over_ja = true
	jogando = false
	som_hit.play()
	spawn_timer.stop()
	bird.die()
	label_gameover.show()
	if score > recorde:
		recorde = score
		salvar_recorde()
		label_recorde.text = "Recorde: " + str(recorde)
