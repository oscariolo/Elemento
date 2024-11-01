extends CharacterBody2D
var facing:Vector2 = Vector2.RIGHT
var playerSize:Vector2 = Vector2(19,33)
var life:int = 1
enum State {
	IDLE,
	RUN,
	JUMP,
	SLIDE,
	IDLE_SLIDE,
	GET_UP,
}

var current_state = State.IDLE


func _ready() -> void:
	_set_properties_attributes()
	$Abilities.add_elemental_ability("water")
	$Abilities.add_elemental_ability('wind')
	$Abilities.add_elemental_ability('fire')
	$Abilities.add_elemental_ability('rock')
	$AnimatedSprite2D.play("idle")

func _set_properties_attributes():
	var player_shape = RectangleShape2D.new()
	player_shape.set_size(playerSize)
	$Hitbox/CollisionShape2D.shape = player_shape
	

func _process(delta: float) -> void:
	if facing == Vector2.LEFT:
		$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.flip_h = false
	
	if $PlayerMovementComponent.sliding:
		current_state = State.SLIDE
	elif $PlayerMovementComponent.jumped:
		current_state = State.JUMP
	elif current_state != State.GET_UP:
		current_state = State.IDLE


	_animation_handler()

func player_hit():
	print("player hit")
	

func _animation_handler():
	if Input.is_action_just_released("slide") && current_state == State.SLIDE:
		$AnimatedSprite2D.play("get_up")
		current_state = State.GET_UP
	
	
	match current_state:
		State.IDLE:
			$AnimatedSprite2D.play("idle")
		State.SLIDE:
			$AnimatedSprite2D.play("slide")
		State.JUMP:
			$AnimatedSprite2D.play("jump")

func _on_hitbox_area_entered(area: Area2D) -> void:
	var object = area.get_parent()
	if object.is_in_group('Projectile'):
		player_hit()
	


func _on_animated_sprite_2d_animation_finished() -> void:
	if $AnimatedSprite2D.get_animation() == 'get_up':
		$AnimatedSprite2D.play("idle")
		current_state = State.IDLE
