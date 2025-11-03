extends Node2D

func _ready():
	$Camera2D.global_position = $LaunchSite/RigidBody2D.global_position
	
func _process(delta: float):
	$Camera2D.global_position = $LaunchSite/RigidBody2D.global_position
