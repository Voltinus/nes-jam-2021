extends "res://templates/Level/Level.gd"


onready var boss_explosion_audio = $BossExplosion


func _ready():
	G.switch_to_audio_2()


func _on_Fall_body_entered(body):
	player.die()
