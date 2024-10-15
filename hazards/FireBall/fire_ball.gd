extends Node2D
var direction: Vector2
var reflected: bool
var speed: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	speed = 300
	direction = Vector2.RIGHT


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	if direction == Vector2.RIGHT:
		$Sprite2D.flip_h = true
	else:
		$Sprite2D.flip_h = false
	
	position += delta * speed * direction
