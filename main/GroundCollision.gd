extends StaticBody2D

@onready var Ground = $"Test collision shape"
const start_size = Vector2(3458.0,115.5)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


#Updates width of ground collision with ball position
func _process(delta: float) -> void:
	Ground.shape.size = start_size + Vector2(Global.Ball.position.x,0)
	#	print(Ground.shape.size)
	delta=delta
	pass
	
