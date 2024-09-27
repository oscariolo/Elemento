extends StaticBody2D
signal relative_position(position:Vector2)
signal body_left

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_area_2d_body_entered(body: Node2D) -> void:
	var position = $Area2D.global_position as Vector2
	relative_position.emit(global_position)


func _on_area_2d_body_exited(body: Node2D) -> void:
	body_left.emit()
