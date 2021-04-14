extends Node


var hp := 5
var hp_max := 10
var score := 0

onready var music = $AudioStreamPlayer

var audio1 = preload("res://misc/mvb.wav")
var audio2 = preload("res://misc/mvb2.wav")


func _ready():
	randomize()


func _on_AudioStreamPlayer_finished():
	play_audio()


func play_audio():
	music.stream_paused = false
	music.play()


func stop_audio():
	music.stream_paused = true


func switch_to_audio_1():
	music.stream = audio1


func switch_to_audio_2():
	music.stream = audio2
