extends Area2D


var velocity : Vector2


func _ready():
	pass


func _physics_process(delta):
	position += velocity * delta
	velocity.y += 2


func _on_PlayerBullet_body_entered(body):
	if body is Enemy:
		body.die($"../Player", true)
	
	queue_free()
