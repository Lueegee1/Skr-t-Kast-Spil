extends ColorRect

@onready var grid_material = $".".material
@onready var ball = $"../../LaunchSite/RigidBody2D"

func _process(_delta):
	var mat = grid_material as ShaderMaterial
	mat.set_shader_parameter("ball_position", ball.global_position)
