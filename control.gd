extends Control
@onready var label_recorde = $LabelRecorde

func _ready():
	var recorde = 0
	if FileAccess.file_exists("user://recorde.save"):
		var arquivo = FileAccess.open("user://recorde.save", FileAccess.READ)
		recorde = arquivo.get_var()
		arquivo.close()
	label_recorde.text = "Recorde: " + str(recorde)

func _on_button_pressed() -> void:
	pass # Replace wi
	get_tree().change_scene_to_file("res://main.tscn")
