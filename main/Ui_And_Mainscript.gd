extends Node2D

@onready var Camera = $UI/Camera2D
@onready var RigidBody = $LaunchSite/RigidBody2D
@onready var XpLabel = $UI/Camera2D/CanvasLayer/XpLabel
@onready var MoneyLabel = $UI/Camera2D/CanvasLayer/MoneyLabel
@onready var PrestigeLabel = $UI/Camera2D/CanvasLayer/PrestigeLabel
var offsetXP = Vector2(0,0)
var offsetMoney = Vector2(0,0)
var offsetPrestige = Vector2(0,0)
	
func _process(_delta: float):
	Camera.global_position = RigidBody.global_position
	XpLabel.text = str(Global.exp)
	MoneyLabel.text = str(Global.money)
	PrestigeLabel.text = str(Global.prestige)
	XpLabel.position = offsetXP
	MoneyLabel.position = offsetMoney
	PrestigeLabel.position = offsetPrestige
	
