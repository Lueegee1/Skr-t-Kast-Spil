extends Node2D


@onready var Camera = $UI/Camera2D
@onready var RigidBody = $LaunchSite/RigidBody2D
@onready var XpLabel = $UI/Camera2D/CanvasLayer/XpLabel
@onready var MoneyLabel = $UI/Camera2D/CanvasLayer/MoneyLabel
@onready var PrestigeLabel = $UI/Camera2D/CanvasLayer/PrestigeLabel
@onready var Upgrades = $UI/Camera2D/CanvasLayer/VBoxContainer
@onready var angle = $UI/Camera2D/CanvasLayer/VBoxContainer/Angle
var possible_angles = [45,45]


var offsetXP = Vector2(0,0)
var offsetMoney = Vector2(200,0)
var offsetPrestige = Vector2(400,0)
var offsetUpgrades = Vector2(800,0)
var angle_price = 5
var friction_price = 5 
var elasticity_price = 5
var speed_price = 5
var air_resistance_price = 5
var shape_price = 5
var gravity_price = 5

# Camera movement variables
var camera_follow_strength := 5.0   # higher = faster follow, lower = more lag
var camera_drag_factor := 0.002     # how much velocity affects the camera offset
var camera_offset := Vector2.ZERO   # temporary offset for drag effect when bofy is moving
	
func _physics_process(delta: float):# update position and money, xp and prestige
	update_camera(delta)
	XpLabel.text = "Xp: " + str(Global.exp)
	MoneyLabel.text = "Money: " + str(Global.money)
	PrestigeLabel.text = "Prestige: " + str(Global.prestige)
	XpLabel.position = offsetXP
	MoneyLabel.position = offsetMoney
	PrestigeLabel.position = offsetPrestige
	Upgrades.position = offsetUpgrades
	


func _on_angle_changed(value: float):
	Global.Ball.launch_angle = value


func _on_angle_upgrade_pressed() -> void:
	if Global.money > angle_price:
		if angle.min_value > 0 and angle.max_value < 90:
			angle.min_value = angle.min_value - 5
			angle.max_value = angle.max_value + 5
			angle_price *= 2
		


func _on_gravity_upgrade_pressed() -> void:
	if Global.money > gravity_price:
		if Global.Ball.gravity > 0.05:
			Global.Ball.gravity = Global.Ball.gravity - 0.05
			Global.money = Global.money - gravity_price
			gravity_price *= 2

func _on_friction_upgrade_pressed() -> void:
	if Global.money > friction_price:
		if Global.Ball.ground_fricion > 0.05:
			Global.Ball.ground_friction = Global.Ball.ground_friction - 0.05
			Global.money = Global.money - friction_price
			friction_price *= 2


func _on_elasticity_upgrade_pressed():
	if Global.money > elasticity_price:
		Global.Ball.ground_elasticity = Global.Ball.ground_elasticity + 5
		Global.money = Global.money - elasticity_price
		elasticity_price *= 2


func _on_speed_upgrade_pressed():
	if Global.money > speed_price:
		Global.Ball.launch_speed = Global.Ball.launch_speed * 1.05
		Global.money = Global.money - speed_price
		speed_price *= 2


func _on_air_resistance_upgrade_pressed() -> void:
	if Global.money > air_resistance_price:
		if Global.Ball.air_resistance > 0.05:
			Global.Ball.air_resistance -= 0.05
			Global.money = Global.money - air_resistance_price

func _on_shape_changed() -> void:
	pass # Replace with function body.

func update_camera(delta: float) -> void:
	var ball = Global.Ball
	var target_pos: Vector2 = ball.global_position
	var desired_camera_pos = target_pos + camera_offset
	Camera.global_position = Camera.global_position.lerp(desired_camera_pos, delta * camera_follow_strength)
