extends Element
@export var player:CharacterBody2D


func load_properties(properties) -> void:
	player = properties[0].get_parent()

func connect_interactions() -> void:
	pass

func _process(delta: float) -> void:
	$FireAttack.global_position = player.global_position + Vector2(30,0)
	if Input.is_action_just_pressed("attack"):
		$FireAttack/HitBox.visible = true
		$FireAttack/SliceAnimation.play("slice")


func _on_slice_animation_animation_finished() -> void:
	$FireAttack/HitBox.visible = false
