extends Area2D
var direction: Vector2
var speed: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	speed = 400
	direction = Vector2.LEFT

func _physics_process(delta: float) -> void:
	if direction == Vector2.RIGHT:
		$Sprite2D.flip_h = true
	else:
		$Sprite2D.flip_h = false
	position += delta * speed * direction

func set_reflected(value:bool):
	direction = direction*-1
	if value:
		set_collision_mask_value(1,false)
		set_collision_layer_value(4,false)
		set_collision_layer_value(5,true)
		set_collision_mask_value(6,true)
	else:
		set_collision_mask_value(1,true)
		set_collision_layer_value(4,true)
		set_collision_layer_value(5,false)
		set_collision_mask_value(6,false)
	
	
	
