extends "res://templates/Enemy/Enemy.gd"


var velocity = Vector2(-1, 0)
var speed = 50
var points = 300
var is_near_wall = false
var is_near_edge = false

onready var sprite = $AnimatedSprite
onready var edge_detector = $EdgeDetector
onready var wall_detector = $WallDetector
onready var reverse_timer = $Timer
onready var collision_shape = $CollisionShape2D

var ScoreUp = preload("res://objects/ScoreUp/ScoreUp.tscn")


func _physics_process(_delta):
	var _ret = move_and_slide(velocity * speed)


var player_hit_accumulator = 0

func _process(_delta):
	if not sprite.visible:
		return
	
	var bodies_wall = wall_detector.get_overlapping_bodies()
	var bodies_edge = edge_detector.get_overlapping_bodies()
	
	if len(bodies_wall):
		for body in bodies_wall:
			if body is Player:
				player_hit_accumulator += 1
				if player_hit_accumulator == 10:
					player_hit_accumulator = 0
					get_parent().get_node("Player").hit()
			else:
				reverse()
	if not len(bodies_edge):
		reverse()


func reverse():
	if not reverse_timer.is_stopped():
		return
	reverse_timer.start(0.2)
	sprite.flip_h = not sprite.flip_h
	edge_detector.position.x *= -1
	wall_detector.position.x *= -1
	wall_detector.rotation_degrees = 0 if wall_detector.rotation_degrees else 180
	velocity.x *= -1


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

func _on_HeadTop_body_entered(body):
	if body is Player:
		if body.velocity.y < 10:
			return
		
		die(body)
