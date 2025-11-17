extends Control

func _on_pressed():
	queue_free()
	Global.in_menu = false
	

func _on_sound_value_changed(value: float):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)
