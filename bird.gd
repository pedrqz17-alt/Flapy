extends CharacterBody2D
@onready var anim = $AnimatedSprite2D

func _ready():
	anim.play("default")

var gravity = 900
var flap_force = -350
var started = false
var dead = false

func _physics_process(delta):
	if not started or dead:
		return
	velocity.y += gravity * delta
	move_and_slide()
	# bateu no chão ou no teto
	if position.y > 1200 or position.y < -50:
		get_parent().game_over()

func flap():
	started = true
	velocity.y = flap_force

func die():
	dead = true
	velocity.y = 0

func _on_area_2d_body_entered(body):
	if body.is_in_group("obstaculo"):
		get_parent().game_over()
@onready var som_music = $SomMusic

func voar():
	velocity.y = -400
	som_music.play()
