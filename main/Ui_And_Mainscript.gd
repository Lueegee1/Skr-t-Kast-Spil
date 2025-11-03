extends Node2D

func _ready():
	$UI/Camera2D.global_position = $LaunchSite/RigidBody2D.global_position
	
func _process(delta: float):
	$UI/Camera2D.global_position = $LaunchSite/RigidBody2D.global_position
