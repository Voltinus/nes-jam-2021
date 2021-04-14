extends Control


func _process(delta):
	if Input.is_action_pressed("a") or Input.is_action_pressed("b") or Input.is_action_pressed("up") or Input.is_action_pressed("down") or Input.is_action_pressed("left") or Input.is_action_pressed("right") or Input.is_action_pressed("select") or Input.is_action_pressed("start"):
		get_tree().change_scene("res://levels/MainMenu/MainMenu.tscn")
