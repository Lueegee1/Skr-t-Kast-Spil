extends Node2D

var increment = 8000


func _ready() -> void:
	pass
func _process(delta: float) -> void:
	delta=delta
	queue_redraw()
	
func _draw() -> void:
	for i in range(10+int(Global.Ball.position.x/increment)):
		var value = float((1-0.1*i))
		print(value)
		draw_rect(Rect2(i*increment,0,increment,10000),Color(value*2,value,value))
	draw_rect(Rect2(-1000,-10000,1000,20000),Color.WHITE)	
	
