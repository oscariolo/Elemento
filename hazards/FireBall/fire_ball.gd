extends Node2D
@export var direction: Vector2 = Vector2.LEFT
@export var speed: float = 400

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	if direction == Vector2.RIGHT:
		$FireBallHitBox/Sprite2D.flip_h = true
	else:
		$FireBallHitBox/Sprite2D.flip_h = false
	position += delta * speed * direction

func set_reflected(value:bool):
	direction = direction*-1
	#when the fireball gets deflected it stops being detected as projectile and changes to reflected projectile
	#it can no longer interact with the player (hitting it) and starts detecting and collisioning with enemies
	#on false the behaviour is reversed
	if value:
		$FireBallHitBox.set_collision_layer_value(4,false)
		$FireBallHitBox.set_collision_layer_value(5,true)
		$FireBallHitBox.set_collision_mask_value(1,false)
		$FireBallHitBox.set_collision_mask_value(6,true)
	else:	
		$FireBallHitBox.set_collision_layer_value(4,true)
		$FireBallHitBox.set_collision_layer_value(5,false)
		$FireBallHitBox.set_collision_mask_value(1,true)
		$FireBallHitBox.set_collision_mask_value(6,false)


func die():
	queue_free()


func _on_fire_ball_hit_box_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		queue_free()
		pass
	if body is TileMapLayer:
		direction = direction*-1
