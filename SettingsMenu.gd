extends Control
@onready var upgrades = get_node("/root/Gamecontroller/UI/Camera2D/CanvasLayer/VBoxContainer")


func _ready():
	Global.settings = self
	print("SETTINGS READY")
	
	
func _on_pressed():
	print("VBox:", upgrades)
	print("visible:", upgrades.visible)
	print("visible_in_tree:", upgrades.visible_in_tree())
	print("upgrades = ", upgrades)
	upgrades.visible = true
	Global.in_menu = false
	queue_free()



func _on_sound_value_changed(value: float):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)
