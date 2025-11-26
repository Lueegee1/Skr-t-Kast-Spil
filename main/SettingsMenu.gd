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
		"exp": 0
	}

	var file = FileAccess.open(Global.SAVE_FILE, FileAccess.WRITE)
	file.store_string(JSON.stringify(data))
	file.close()
	Global.Ball.launch_speed = 500.0                # speed that the RigidBody2D is launched with
	Global.Ball.launch_angle = 45.0                 # angle of launch of the RigidBody2D
	Global.Ballstop_threshold = 5.0                      # velocity threshold rquired for the RigidBody2D to be considered stopped
	Global.Ballstop_delay = 1.0                          # seconds it must stay still to count as stopped
	Global.Ball.time_between_launch = 0.5                  # the time between launch command being given and the RigidBody2D actually being launched
	Global.Ball.air_resistance = 0.5                     # uses the "damp" variable as air resistance
	Global.Ball.gravity = 1                                # uses the "gravity_scale" as gravity
	Global.Ball.ground_friction = 0.1                     # uses PhysicsMaterial's "friction" as friction
	Global.Ball.ground_elasticity = 0.5                    # uses PhysicsMaterial's "bounce" as the grounds elasticity
	Global.exp = 0
	Global.money = 0
	Global.prestige = 0
