extends "res://templates/Enemy/Enemy.gd"


var alive = true
var hp_max = 15
var hp = hp_max

var EnemyBullet = preload("res://objects/EnemyBullet/EnemyBullet.tscn")
var Explosion = preload("res://objects/Explosion/Explosion.tscn")

onready var player = $"../Player"
onready var hp_foreground = $HPForeground
onready var hp_background = $HPBackground
onready var timer = $Timer
onready var explosion_audio = $BossExplosion


func _on_Timer_timeout():
	var bullet = EnemyBullet.instance()
	bullet.position = position
	bullet.init((player.position - position).normalized())
	get_parent().add_child(bullet)


# actually hit, but whatever
func die(player, died_from_bullet):
	if not alive:
		return
	
	hp -= 1
	update_stats()
	
	if hp == 0:
		alive = false
		remove_child(timer)
		hp_background.visible = false
		hp_foreground.visible = false
		G.stop_audio()
		explosion_audio.play()
		
		for i in range(3):
			var explosion = Explosion.instance()
			explosion.position = position
			get_parent().add_child(explosion)
			yield(get_tree().create_timer(0.5), "timeout")
		
		get_tree().change_scene("res://levels/GameOver/GameOver.tscn")
	


func update_stats():
	hp_foreground.rect_size.x = (float(hp)/hp_max)*32
