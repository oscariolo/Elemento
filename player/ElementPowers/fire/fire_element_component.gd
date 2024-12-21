extends Element
var hitting: bool = false
@export var effective_hit_time:float = 0.1

func _ready() -> void:
	$FireAttack/SliceAnimation.stop()
	$FireAttack/HitBox/CollisionShape2D.disabled = true
	$EffectiveHitTimer.wait_time = effective_hit_time

func load_properties() -> void:
	#var sliceShape = RectangleShape2D.new()
	#sliceShape.set_size(player.playerSize*2)
	#$FireAttack/HitBox/CollisionShape2D.shape =sliceShape
	pass

func _process(_delta: float) -> void:
	$FireAttack.global_position = player.global_position 
	if Input.is_action_just_pressed("attack"):
		hitting = true
		$EffectiveHitTimer.start()
		$FireAttack/SliceAnimation.play("slice")
		if player.facing == Vector2.RIGHT:
			$FireAttack/SliceAnimation.flip_h = true
		else:
			$FireAttack/SliceAnimation.flip_h = false
	
	if hitting:
		$FireAttack/HitBox/CollisionShape2D.disabled = false
	else:
		$FireAttack/HitBox/CollisionShape2D.disabled = true


func _on_slice_animation_animation_finished() -> void:
	$FireAttack/HitBox/CollisionShape2D.disabled = true


func _on_hit_box_area_entered(area: Area2D) -> void:
	var object = area.get_parent()
	if object.is_in_group("Projectile"):
		object.set_reflected(true)
	


func _on_effective_hit_timer_timeout() -> void:
	hitting = false
