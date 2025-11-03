extends Node2D

@onready var Camera = $Camera2D
@onready var RigidBody = $LaunchSite/RigidBody2D
@onready var XpLabel = $UI/Camera2D/XpLabel
@onready var MoneyLabel = $UI/Camera2D/MoneyLabel
@onready var PrestigeLabel = $UI/Camera2D/PrestigeLabel
	
func _process(_delta: float):
	Camera.global_position = RigidBody.global_position
	XpLabel.text = Global.exp
	MoneyLabel.text = Global.money
	PrestigeLabel.text = Global.prestige
	
