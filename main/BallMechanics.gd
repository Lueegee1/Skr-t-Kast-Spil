extends RigidBody2D
# To Do:
# Look into angular Damp, what it is and if its relevant
# Look into physicsMaterial Absorbent clause, what it does and if it relevant
# fix bounce so that x_velocity is kept (currently isnt)

#------------------------------------------ Setup ------------------------------------------

# exported variables
@export var launch_speed: float = 1000.0                # speed that the RigidBody2D is launched with
@export var launch_angle: float = 45.0                 # angle of launch of the RigidBody2D
@export var stop_threshold := 5.0                      # velocity threshold rquired for the RigidBody2D to be considered stopped
@export var stop_delay := 1.5                          # seconds it must stay still to count as stopped
@export var time_between_launch = 0.5                  # the time between launch command being given and the RigidBody2D actually being launched
@export var air_resistance = 0.0                       # uses the "damp" variable as air resistance
@export var gravity = 1.0                              # uses the "gravity_scale" as gravity
@export var ground_friction = 1.0                      # uses PhysicsMaterial's "friction" as friction
@export var ground_elasticity = 1.0                    # uses PhysicsMaterial's "bounce" as the grounds elasticity

# variables
var still_time := 0.0                                  # var to hold the ellapsed time the RigidBody2D has been stationary  
var BodyMaterial = PhysicsMaterial.new()               # makes a new PhysicsMaterial from where friction and bounce can be edited

# defining object paths
@onready var StartPos = $"../Marker2D".global_position # start position of the RigidBody2D
@onready var Sprite = $Sprite2D                        # sprite of the RigidBody2D
@onready var collision = $CollisionPolygon2D           # collision of the RigidBody2D

#------------------------------------------ Code ------------------------------------------

func _ready() -> void:
	Global.Ball = self
	initiate_Launch()

func initiate_Launch(): # sets up variables, waits a bit then calls the launch function LaunchRigidBody()
	global_position = StartPos
	linear_velocity = Vector2.ZERO
	reload_variables()
	await get_tree().create_timer(time_between_launch).timeout
	launchRigidBody(launch_angle)
	
func launchRigidBody(angle): # launch RigidBody at input angle
	var radians = deg_to_rad(angle)
	linear_velocity = Vector2(cos(radians), -sin(radians)) * launch_speed

func _physics_process(delta): # called every frame
# RigidBody is not moving check
	if linear_velocity.length() < stop_threshold:
		still_time += delta
	else:
		still_time = 0
	if still_time >= stop_delay:
		initiate_Launch()

func reload_variables(): # reloads all variables used in physics calculations
	linear_damp = air_resistance
	gravity_scale = gravity
	BodyMaterial.friction = ground_friction
	BodyMaterial.bounce = ground_elasticity
