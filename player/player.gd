extends CharacterBody2D
var facing:Vector2 = Vector2.RIGHT
var playerSize:Vector2 = Vector2(43,65)


func _ready() -> void:
	_set_properties_attributes()
	#$Abilities.add_elemental_ability("water")
	#$Abilities.add_elemental_ability('wind')
	#$Abilities.add_elemental_ability('fire')
	$Abilities.add_elemental_ability('rock')

func _set_properties_attributes():
	var player_shape = RectangleShape2D.new()
	player_shape.set_size(playerSize)
	$Hitbox/CollisionShape2D.shape = player_shape
	

func _process(delta: float) -> void:
	if facing == Vector2.LEFT:
		$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.flip_h = false
	

func _physics_process(delta: float) -> void:
	pass


func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group('Projectile'):
		print("hit player")
