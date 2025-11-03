extends Node2D


func _ready() -> void:
	pass
func _process(delta: float) -> void:
	delta=delta
	queue_redraw()
	
func _draw() -> void:
	draw_rect(Rect2(0,0,2000,2000),Color.WHITE,true)
