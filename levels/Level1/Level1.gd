extends "res://templates/Level/Level.gd"


func _ready():
	VisualServer.set_default_clear_color(Color(0, 0.44, 0.9255, 1.0))
	$"ForegroundObjects/Player".camera.limit_right = 1792


func _on_Area2D_body_entered(body):
	get_tree().change_scene("res://levels/Level2/Level2.tscn")


func _on_Fall_body_entered(body):
	player.die()
