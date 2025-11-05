extends ColorRect

@onready var grid = $"."
@onready var ball = $"../../LaunchSite/RigidBody2D"
@onready var camera = $"../../UI/Camera2D"

func _process(_delta):
	var mat = grid.material as ShaderMaterial

	# Pass ball position and camera offset to shader
	mat.set_shader_parameter("ball_position", ball.global_position)
	mat.set_shader_parameter("world_offset", camera.get_screen_center_position() - camera.offset)
