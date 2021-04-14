extends CanvasLayer


onready var hearts = $Hearts
onready var score = $Score


var Heart = preload("res://templates/Level/GUI/Heart/Heart.tscn")
onready var Player = $"../ForegroundObjects/Player"


func _ready():
	for i in range(G.hp):
		var node = Heart.instance()
		node.play("full")
		node.position.x = -i * 8
		hearts.add_child(node)


func _on_Player_stats_changed():
	var new_score = str(G.score)
	while len(new_score) != 8:
		new_score = "0" + new_score
	score.text = str(new_score)
	
	for i in hearts.get_children():
		i.queue_free()
	
	for i in range(G.hp):
		var node = Heart.instance()
		node.play("full")
		node.position.x = -i * 8
		hearts.add_child(node)
