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


func _on_reset_button_pressed():
	var data = {
		"money": 0,
		"prestige": 0,
		"exp": 0,
		"launch_angle": 45,
		"air_resistance": 0.5,
		"gravity": 1.0,
		"ground_friction": 0.1,
		"ground_elasticity": 0.5
	}

	var file = FileAccess.open(Global.SAVE_FILE, FileAccess.WRITE)
	file.store_string(JSON.stringify(data))
	file.close()
