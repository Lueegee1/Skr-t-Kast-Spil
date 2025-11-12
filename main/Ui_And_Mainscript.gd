extends Node2D


@onready var Camera = $UI/Camera2D
@onready var RigidBody = $LaunchSite/RigidBody2D
@onready var XpLabel = $UI/Camera2D/CanvasLayer/XpLabel
@onready var MoneyLabel = $UI/Camera2D/CanvasLayer/MoneyLabel
@onready var PrestigeLabel = $UI/Camera2D/CanvasLayer/PrestigeLabel
@onready var Upgrades = $UI/Camera2D/CanvasLayer/VBoxContainer
@onready var angle = $UI/Camera2D/CanvasLayer/VBoxContainer/Angle
@onready var shapes = ["4kant", "5kant", "6kant", "7kant", "8kant","9kant","10kant"]
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
var change_shape_price = 5
var shape_number = 0

func _rounding(num):
	var exponent = int(log(num+1)/log(10))
	var suffixes = ["","K","M","B","T","Qu","Qi","Sx","Sp","O","N","Dc"]
	for i in range(suffixes.size()):
		if (3*i) <= exponent and exponent <(3+3*i):
			exponent = 3*i
			return str((round(float(num)/(10**exponent)*10))/10) + suffixes[i]
		else:
			pass

func _process(_delta: float):# update position and money, xp and prestige
	Camera.global_position = RigidBody.global_position #updates camera position
	XpLabel.text = "Xp: " + _rounding(Global.exp)
	MoneyLabel.text = "Money: " + _rounding(Global.money)
	PrestigeLabel.text = "Prestige: " + _rounding(Global.prestige)
	XpLabel.position = offsetXP
	MoneyLabel.position = offsetMoney
	PrestigeLabel.position = offsetPrestige
	Upgrades.position = offsetUpgrades
	


func _on_angle_changed(value: float):
	Global.Ball.launch_angle = value


func _on_angle_upgrade_pressed():
	if Global.money > angle_price:
		if angle.min_value > 0 and angle.max_value < 90:
			angle.min_value = angle.min_value - 5
			angle.max_value = angle.max_value + 5
			angle_price *= 2
		


func _on_gravity_upgrade_pressed():
	if Global.money > gravity_price:
		if Global.Ball.gravity > 0.05:
			Global.Ball.gravity = Global.Ball.gravity - 0.05
			Global.money = Global.money - gravity_price
			gravity_price *= 2

func _on_friction_upgrade_pressed():
	if Global.money > friction_price:
		if Global.Ball.ground_friction > 0.05:
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
		if Global.Ball.air_resistance > 0.001:
			Global.Ball.air_resistance -= 0.001
			Global.money = Global.money - air_resistance_price

#func_on_shape_changed():
#if Global.money > change_shape_price:
#	if Global.Ball.collision.shape != $"10kant":
#		Global.Ball.collision.shape = shapes[shape_number]
#		shape_number += 1
#		Global.money -= change_shape_price
#		print(shapes[shape_number])
