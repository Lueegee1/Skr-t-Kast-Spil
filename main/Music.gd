extends Node

#var music_player: AudioStreamPlayer
var theme = "res://Assets/Sound/Main theme loopable.mp3"
const impact_volume = 38
const wind_volume = 10
@onready var theme_player = $ThemePlayer
@onready var player_wind = $WindPlayer
	

func play_main_theme():
	#var stream = load("res://Assets/Sound/Main theme loopable.wav")
	#stream.loop_mode = AudioStreamWAV.LOOP_FORWARD
	#theme_player.stream = stream
	theme_player.play()
	
func play_impact():
	var player_impact = AudioStreamPlayer.new()
	var volume = log((Global.Ball.linear_velocity.length()))-impact_volume
	volume = clamp(volume,-100,20)
	player_impact.volume_db += volume
	player_impact.stream = preload("res://Assets/Sound/Impact2.wav")
	add_child(player_impact)
	player_impact.play()
	player_impact.connect("finished", player_impact.queue_free)
	
func play_wind():
	#var player_wind = AudioStreamPlayer.new()
	#var wind = preload("res://Assets/Sound/Wind.wav")
	#wind.loop_mode = AudioStreamWAV.LOOP_FORWARD
	#player_wind.stream = wind
	player_wind.play()

func stop_music(music_player: Node):
	music_player.stop()
	music_player.queue_free

func _ready() -> void:
	play_main_theme()
	play_wind()
	pass
func _process(_delta: float) -> void:
	var volume = log((Global.Ball.linear_velocity.length()))-wind_volume
	volume = clamp(volume,-100,20)
	player_wind.volume_db = 0 + volume


func _on_rigid_body_2d_body_shape_entered(body_rid: RID, body: Node, body_shape_index: int, local_shape_index: int) -> void:
	#print("FIVE BIG BOOMs")
	play_impact()
	pass # Replace with function body.
