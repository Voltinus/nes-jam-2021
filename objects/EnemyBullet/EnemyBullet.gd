extends Area2D


var speed = 200

var dir : Vector2


func _physics_process(delta):
	position += dir * speed * delta


func init(new_dir):
	dir = new_dir


func _on_EnemyBullet_body_entered(body):
	if body is Player:
		body.hit()
	
	queue_free()
