extends Line2D
class_name Trails
 
var queue : Array
@export var MAX_LENGTH : int
var width_scaling=0.5

func _process(_delta):
	var pos = _get_position()
 
	queue.push_back(pos)


	
	if queue.size() > MAX_LENGTH:
		queue.pop_front()
 
	clear_points()
 
 	
	for point in queue:
		add_point(point)
	width = ((Global.Ball.linear_velocity).length())**width_scaling -4
	width = clamp(width,0,40)
func _get_position():
	return Global.Ball.position - Vector2(580.0,-325.0) #Camera coords + slight correction
