class_name Pickup
extends Area2D


enum TYPES { 
	COIN, COIN_BAG, DIAMOND,
	LEEK, SPAGHETTI, GREEN_APPLE, RED_APPLE, CHERRY, BANANA
}

export(TYPES) var type setget type_set

onready var collision_shape = $CollisionShape2D

var ScoreUp := preload("res://objects/ScoreUp/ScoreUp.tscn")


func _on_Pickup_body_entered(body):
	if not visible:
		return
	visible = false
	
	var ret = body.pickup(type)
	if ret:
		var score_up = ScoreUp.instance()
		score_up.rect_position = position + Vector2(0, -5)
		get_parent().add_child(score_up)
		score_up.init(ret)
		yield(score_up, "animation_finished")
	
	queue_free()


func type_set(new_value):
	type = new_value
