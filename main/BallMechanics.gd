extends RigidBody2D

# exported variables
@export var launch_speed: float = 500.0      # speed that the RigidBody2D is launched with
@export var launch_angle: float = 45.0       # angle of launch of the RigidBody2D
@export var stop_threshold := 0.0            # velocity threshold rquired for the RigidBody2D to be considered stopped
@export var stop_delay := 1.5                # seconds it must stay still to count as stopped
@export var time_between_launch = 0.5        # the time between launch command being given and the RigidBody2D actually being launched

# variables
var still_time := 0.0                        # var to hold the ellapsed time the RigidBody2D has been stationary  

# defining objects
@onready var StartPos = $"../Marker2D"       # start position of the RigidBody2D
@onready var Sprite = $Sprite2D              # sprite of the RigidBody2D
@onready var collision = $CollisionPolygon2D # collision of the RigidBody2D

func _ready() -> void:
# launches the polygon soon after running the scene
	await get_tree().create_timer(time_between_launch).timeout
	LaunchRigidBody(launch_angle) 

func LaunchRigidBody(angle):
	var radians = deg_to_rad(angle)
	linear_velocity = Vector2(cos(radians), -sin(radians)) * launch_speed

func RigidBodyStopped():
	global_position = StartPos
	LaunchRigidBody(launch_angle)

func _physics_process(delta):
# RigidBody is still clause
	if linear_velocity.length() < stop_threshold:
		still_time += delta
	else:
		still_time = 0.0
	
	if still_time >= stop_delay:
		RigidBodyStopped()
