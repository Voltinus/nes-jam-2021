extends "res://templates/Pickup/Pickup.gd"


func _ready():
	type = randi()%6+3
	$AnimatedSprite.play("food" + str(type))
