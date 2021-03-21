extends KinematicBody2D


var velocity : Vector2
var speed = 150

onready var camera = $Camera2D


func _physics_process(_delta):
	velocity.x = (Input.get_action_strength("right") - Input.get_action_strength("left")) * speed
	if is_on_floor() and Input.is_action_pressed("up"):
		velocity.y = -250
	
	var ret = move_and_slide(velocity, Vector2.UP)
	if not is_on_floor():
		velocity.y += 10
	else:
		velocity.y = 0
	
	camera.limit_left = max(camera.limit_left, position.x - 128)
