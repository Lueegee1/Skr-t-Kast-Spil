extends ColorRect

@onready var grid = $"."
@onready var ball = $"../../LaunchSite/RigidBody2D"
@onready var camera = $"../../UI/Camera2D"

var startsize = Vector2(60746.0,23408.0)

func _process(_delta):
	var mat = grid.material as ShaderMaterial
	var screen_top_left = camera.get_screen_center_position() - (get_viewport_rect().size / 2) * camera.zoom

	mat.set_shader_parameter("camera_origin", screen_top_left)
	mat.set_shader_parameter("ball_position", ball.global_position)
	
	size = startsize+ Global.Ball.position
