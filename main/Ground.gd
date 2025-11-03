extends Node2D

var increment = 2000


func _ready() -> void:
	pass
func _process(delta: float) -> void:
	delta=delta
	queue_redraw()
	
func _draw() -> void:
	for i in range(4):
		draw_rect(Rect2(i*increment,0,(i+1)*increment,(i+1)*increment),Color(255+10*i,255+10*i,255+10*i))
	
