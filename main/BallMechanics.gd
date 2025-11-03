extends RigidBody2D
# To Do:
# Look into angular Damp, what it is and if its relevant

#------------------------------------------ Setup ------------------------------------------

# exported variables
@export var launch_speed: float = 500.0      # speed that the RigidBody2D is launched with
@export var launch_angle: float = 45.0       # angle of launch of the RigidBody2D
@export var stop_threshold := 0.0            # velocity threshold rquired for the RigidBody2D to be considered stopped
@export var stop_delay := 1.5                # seconds it must stay still to count as stopped
@export var time_between_launch = 0.5        # the time between launch command being given and the RigidBody2D actually being launched
@export var air_resistance = 1               # uses the "Damp" variable as air resistance

# variables
var still_time := 0.0                        # var to hold the ellapsed time the RigidBody2D has been stationary  

# defining objects
@onready var StartPos = $"../Marker2D"       # start position of the RigidBody2D
@onready var Sprite = $Sprite2D              # sprite of the RigidBody2D
@onready var collision = $CollisionPolygon2D # collision of the RigidBody2D

#------------------------------------------ Code ------------------------------------------

func _ready() -> void: # sets ud variables, waits a bit then calls the launch function LaunchRigidBody()
	linear_damp = air_resistance
	await get_tree().create_timer(time_between_launch).timeout
	launchRigidBody(launch_angle) 

func launchRigidBody(angle): # launch RigidBody at input angle
	var radians = deg_to_rad(angle)
	linear_velocity = Vector2(cos(radians), -sin(radians)) * launch_speed

func rigidBodyStopped(): # reset position and velocity of the RigidBody2D
	global_position = StartPos
	linear_velocity = Vector2.ZERO
	launchRigidBody(launch_angle)

func _physics_process(delta):
# RigidBody is not moving cause
	if linear_velocity.length() < stop_threshold:
		still_time += delta
	else:
		still_time = 0.0
	
	if still_time >= stop_delay:
		rigidBodyStopped()

func reload_variables(): # reloads all variables
	linear_damp = air_resistance
	
	
