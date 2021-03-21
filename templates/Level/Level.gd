extends Node2D


onready var left_wall = $LeftWall
onready var foreground = $ForegroundObjects
onready var player = foreground.get_node("Player")


func _physics_process(_delta):
	left_wall.position.x = foreground.get_node("Player/Camera2D").limit_left
