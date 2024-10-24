extends Element
@export var player:CharacterBody2D

func _ready() -> void:
	$FireAttack/SliceAnimation.stop()
	$FireAttack/HitBox/CollisionShape2D.disabled = true

func load_properties(properties) -> void:
	player = properties[0].get_parent()

func connect_interactions() -> void:
	pass

func _process(delta: float) -> void:
	$FireAttack.global_position = player.global_position + Vector2(30,0)*player.facing
	if Input.is_action_just_pressed("attack"):
		$FireAttack/HitBox/CollisionShape2D.disabled = false
		$FireAttack/SliceAnimation.play("slice")
		if player.facing == Vector2.RIGHT:
			$FireAttack/SliceAnimation.flip_h = true
		else:
			$FireAttack/SliceAnimation.flip_h = false


func _on_slice_animation_animation_finished() -> void:
	$FireAttack/HitBox/CollisionShape2D.disabled = true


func _on_hit_box_area_entered(area: Area2D) -> void:
	if area.is_in_group("Projectile"):
		area.direction = Vector2(area.direction.x*-1,0)
	
