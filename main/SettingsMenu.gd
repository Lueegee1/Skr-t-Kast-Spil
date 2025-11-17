extends Control

func _on_pressed():
	queue_free()


func _on_sound_value_changed(value: float):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)


func _on_screen_mode_pressed() -> void:
	var mode = DisplayServer.window_get_mode()
	if mode == DisplayServer.WINDOW_MODE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
