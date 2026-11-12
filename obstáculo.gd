extends Node2D

signal score_ponto
var SPEED = 220
var ja_pontuou = false

func _process(delta):
	position.x -= SPEED * delta
	# passou do pássaro, ganha ponto
	if not ja_pontuou and position.x < 180:
		ja_pontuou = true
		score_ponto.emit()
	if position.x < -100:
		queue_free()

func _on_cima_body_entered(body):
	if body.name == "Bird":
		get_parent().game_over()

func _on_baixo_body_entered(body):
	if body.name == "Bird":
		get_parent().game_over()


func _on_ponto_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
