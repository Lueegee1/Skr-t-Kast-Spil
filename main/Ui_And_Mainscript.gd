extends Node2D

@onready var Camera = $UI/Camera2D
@onready var RigidBody = $LaunchSite/RigidBody2D
@onready var XpLabel = $UI/Camera2D/XpLabel
@onready var MoneyLabel = $UI/Camera2D/MoneyLabel
@onready var PrestigeLabel = $UI/Camera2D/PrestigeLabel
var offsetXP = Vector2(-500,0)
var offsetMoney = Vector2(-250,0)
var offsetPrestige = Vector2(0,0)
	
func _process(_delta: float):
	Camera.global_position = RigidBody.global_position
	XpLabel.text = str(Global.exp)
	MoneyLabel.text = str(Global.money)
	PrestigeLabel.text = str(Global.prestige)
	XpLabel.global_position = Camera.global_position + offsetXP
	MoneyLabel.global_position = Camera.global_position + offsetMoney
	PrestigeLabel.global_position = Camera.global_position+ offsetPrestige
	
