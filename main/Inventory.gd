extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.Inventory = self
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if -Global.Ball.position.y > Global.exp:
		Global.exp = int(-Global.Ball.position.y)
	pass
func _get_money(pos):
	Global.money += pos
	Global.money = int(Global.money)
func _remove_money(price):
	Global.money -= price
	Global.money = int(Global.money)
