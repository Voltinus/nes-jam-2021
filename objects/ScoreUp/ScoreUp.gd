extends Label


signal animation_finished


func init(score):
	text = str(score)
	rect_position.x -= len(text) * 4
	for _i in range(10):
		yield(get_tree().create_timer(0.02), "timeout")
		rect_position.y -= 2
	emit_signal("animation_finished")
	queue_free()
