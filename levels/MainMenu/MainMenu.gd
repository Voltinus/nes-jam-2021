extends Control


func _ready():
	VisualServer.set_default_clear_color(Color(0, 0, 0, 1.0))
	G.switch_to_audio_1()


func _process(_delta):
	if Input.is_action_pressed("start"):
		get_tree().change_scene("res://levels/Level1/Level1.tscn")
