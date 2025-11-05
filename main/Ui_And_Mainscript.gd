extends Node2D

@onready var Camera = $UI/Camera2D
@onready var RigidBody = $LaunchSite/RigidBody2D
@onready var XpLabel = $UI/Camera2D/CanvasLayer/XpLabel
@onready var MoneyLabel = $UI/Camera2D/CanvasLayer/MoneyLabel
@onready var PrestigeLabel = $UI/Camera2D/CanvasLayer/PrestigeLabel
var possible_angles = [45,45]


var offsetXP = Vector2(0,0)
var offsetMoney = Vector2(200,0)
var offsetPrestige = Vector2(400,0)
	
func _process(_delta: float):# update position and money, xp and prestige
	Camera.global_position = RigidBody.global_position #updates camera position
	XpLabel.text = "Xp: " + str(Global.exp)
	MoneyLabel.text = "Money: " + str(Global.money)
	PrestigeLabel.text = "Prestige: " + str(Global.prestige)
	XpLabel.position = offsetXP
	MoneyLabel.position = offsetMoney
	PrestigeLabel.position = offsetPrestige
	
