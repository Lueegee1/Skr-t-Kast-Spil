extends Node

#var music_player: AudioStreamPlayer
var theme = "res://Assets/Sound/Main theme loopable.mp3"
@onready var music_player = $AudioStreamPlayer
func _ready():
	Global.Music = self	

func play_main_theme(stream: AudioStream):
	music_player.stream = stream
	music_player.play()

func stop_music():
	music_player.stop()
