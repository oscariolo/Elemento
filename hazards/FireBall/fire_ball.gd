extends Node2D
var direction: Vector2
var speed: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	speed = 400
	direction = Vector2.LEFT

func _physics_process(delta: float) -> void:
	if direction == Vector2.RIGHT:
		$FireBallHitBox/Sprite2D.flip_h = true
	else:
		$FireBallHitBox/Sprite2D.flip_h = false
	position += delta * speed * direction

func set_reflected(value:bool):
	direction = direction*-1
	if value:
		$FireBallHitBox.set_collision_mask_value(1,false)
		$FireBallHitBox.set_collision_layer_value(4,false)
		$FireBallHitBox.set_collision_layer_value(5,true)
		$FireBallHitBox.set_collision_mask_value(6,true)
	else:
		$FireBallHitBox.set_collision_mask_value(1,true)
		$FireBallHitBox.set_collision_layer_value(4,true)
		$FireBallHitBox.set_collision_layer_value(5,false)
		$FireBallHitBox.set_collision_mask_value(6,false)


func die():
	queue_free()
