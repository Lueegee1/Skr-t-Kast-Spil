extends StaticBody2D

@onready var Ground = $"Test collision shape"
const start_size = Vector2(3458.0,5886.0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.Ground = self
	pass # Replace with function body.


#Updates width of ground collision with ball position
func _ground_update(pos):
	Ground.shape.size = start_size + 5*Vector2(pos,0)


#func _process(delta: float) -> void:
#	pass
