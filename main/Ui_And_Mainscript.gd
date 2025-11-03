extends Node2D

@onready var Camera = $Camera2D
@onready var RigidBody = $LaunchSite/RigidBody2D
	
func _process(_delta: float):
	Camera.global_position = RigidBody.global_position
