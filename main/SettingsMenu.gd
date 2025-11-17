extends Control

func _on_pressed():
	queue_free()


func _on_sound_value_changed(value: float):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)


func _on_screen_mode_pressed() -> void:
	pass # Replace with function body.
