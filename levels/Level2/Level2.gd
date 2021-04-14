extends "res://templates/Level/Level.gd"


func _ready():
	#VisualServer.set_default_clear_color(Color(0.094, 0.235, 0.361, 1.0))
	VisualServer.set_default_clear_color(Color(0, 0, 0, 1))
	$"ForegroundObjects/Player".camera.limit_right = 1584


func _on_Area2D_body_entered(body):
	get_tree().change_scene("res://levels/Level3/Level3.tscn")


func _on_Fall_body_entered(body):
	player.die()
