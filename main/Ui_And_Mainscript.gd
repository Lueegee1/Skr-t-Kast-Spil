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
	
func _process(_delta: float):# update position and money, xp and prestige
	Camera.global_position = RigidBody.global_position #updates camera position
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
		


func _on_gravity_upgrade_pressed() -> void:
	if Global.Ball.gravity > 0.05:
		Global.Ball.gravity = Global.Ball.gravity - 0.05
	


func _on_friction_upgrade_pressed() -> void:
	pass # Replace with function body.


func _on_elasticity_upgrade_pressed():
	Global.Ball.ground_elasticity = Global.Ball.ground_elasticity + 5


func _on_speed_upgrade_pressed() -> void:
	Global.Ball.launch_speed = Global.Ball.launch_speed * 1.05


func _on_air_resistance_upgrade_pressed() -> void:
	pass # Replace with function body.


func _on_shape_changed() -> void:
	pass # Replace with function body.
