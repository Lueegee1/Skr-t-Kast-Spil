extends ColorRect

@onready var grid = $"."
@onready var ball = $"../../LaunchSite/RigidBody2D"
@onready var camera = $"../../UI/Camera2D"

var startsize = Vector2(60746.0,23408.0)

func  _ready() -> void:
	Global.Background = self


func _process(_delta):
	var mat = grid.material as ShaderMaterial
	var screen_top_left = camera.get_screen_center_position() - (get_viewport_rect().size / 2) * camera.zoom

	mat.set_shader_parameter("camera_origin", screen_top_left)
	mat.set_shader_parameter("ball_position", ball.global_position)
	
func _background_update(pos):
	size = startsize+ 10*Vector2(pos.x, -pos.y)
	position = Vector2(-1396.0,-(size.y)+863.0) #863 is the y value of position when the y value of size is 0
	#print(size)
