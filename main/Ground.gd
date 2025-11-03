extends Node2D

var increment = 2000
var lev1 = increment
var lev2 = 2*increment
var lev3 = 3*increment

func _ready() -> void:
	pass
func _process(delta: float) -> void:
	delta=delta
	queue_redraw()
	
func _draw() -> void:
	draw_rect(Rect2(0,0,lev1,lev1),Color.WHITE,true)
	draw_rect(Rect2(lev1,lev1,lev2,lev2),Color.AQUAMARINE,true)
	draw_rect(Rect2(lev2,lev2,lev3,lev3),Color.MEDIUM_SPRING_GREEN,true)
