extends "res://templates/Enemy/Enemy.gd"


onready var player = $"../Player"
onready var sprite = $AnimatedSprite
onready var collision_shape = $CollisionShape2D
onready var timer = $Timer

var EnemyBullet = preload("res://objects/EnemyBullet/EnemyBullet.tscn")
var ScoreUp = preload("res://objects/ScoreUp/ScoreUp.tscn")


func _ready():
	timer.start()


func _process(delta):
	 sprite.flip_h = player.position.x > position.x


var player_in_range = false

func _on_ShootingRange_body_entered(body):
	player_in_range = body is Player
	_on_Timer_timeout()

func _on_ShootingRange_body_exited(body):
	player_in_range = not body is Player


func _on_Timer_timeout():
	var bullet = EnemyBullet.instance()
	bullet.position = position
	bullet.init((player.position - position).normalized())
	get_parent().add_child(bullet)
	
	if player_in_range:
		timer.start()


func die(body, killed_by_bullet=false):
	sprite.visible = false
	collision_shape.disabled = true
	
	if not killed_by_bullet:
		body.velocity.y = -100
	
	var score_up = ScoreUp.instance()
	score_up.rect_position = position + Vector2(0, -5)
	get_parent().add_child(score_up)
	score_up.init(300)
	G.score += 300
	body.emit_changed_stats()
	
	queue_free()
