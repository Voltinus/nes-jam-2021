class_name Player
extends KinematicBody2D


onready var camera := $Camera2D
onready var sprite := $AnimatedSprite
onready var shoot_player := $ShootPlayer
onready var death_player := $DeathPlayer

var PlayerBullet = preload("res://objects/PlayerBullet/PlayerBullet.tscn")

var velocity : Vector2
var speed := 100
var jump_height := 350
var alive = true


signal stats_changed


func _physics_process(_delta):
	if not alive:
		return
	
	velocity.x = (Input.get_action_strength("right") - Input.get_action_strength("left")) * speed
	if is_on_floor() and Input.is_action_pressed("up"):
		velocity.y = -jump_height
	
	var temp_velocity := Vector2(
		max(min(velocity.x, 200), -200),
		max(min(velocity.y, 200), -200)
	)
	var _ret = move_and_slide(temp_velocity, Vector2.UP)
	if not is_on_floor():
		velocity.y += 15
	else:
		velocity.y = 0
	
	if is_on_ceiling() and velocity.y < 0:
		velocity.y = 0
	
	if velocity.x > 0:
		sprite.flip_h = false
	elif velocity.x < 0:
		sprite.flip_h = true
	
	if velocity.x != 0:
		sprite.play("walk")
	else:
		sprite.play("idle")
	
	if Input.is_action_just_pressed("b"):
		var bullet = PlayerBullet.instance()
		get_parent().add_child(bullet)
		bullet.position = position
		bullet.velocity = Vector2(-200 if sprite.flip_h else 200, 0)
		shoot_player.play()
	
	#camera.limit_left = max(camera.limit_left, position.x - 128)


func hit():
	G.hp -= 1
	if G.hp == 0:
		die()
	emit_changed_stats()


func die():
	alive = false
	sprite.set_deferred("disabled", true)
	G.stop_audio()
	death_player.play()
	
	velocity = Vector2(0.4, -1)
	for i in range(100):
		position += velocity
		velocity.y += 0.2
		camera.offset.x -= 0.4
		if position.y >= 270:
			break
		yield(get_tree().create_timer(0.01), "timeout")
	
	G.play_audio()
	get_tree().reload_current_scene()


func emit_changed_stats():
	emit_signal("stats_changed")


func pickup(type):
	var ret = null
	match type:
		Pickup.TYPES.COIN:
			ret = 10
		Pickup.TYPES.COIN_BAG:
			ret = 50
		Pickup.TYPES.DIAMOND:
			ret = 200
		_: # food
			ret = 20
			G.hp = min(G.hp + 3, G.hp_max)
	
	if ret:
		G.score += ret
	
	emit_changed_stats()
	return ret
