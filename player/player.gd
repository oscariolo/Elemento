extends CharacterBody2D
var facing:Vector2 = Vector2.RIGHT
@export var playerSize:Vector2 = Vector2(19,33)
var life:int = 1

func _ready() -> void:
	_set_properties_attributes()
	$Abilities.add_elemental_ability("water")
	$Abilities.add_elemental_ability('wind')
	$Abilities.add_elemental_ability('fire')
	#$Abilities.add_elemental_ability('rock')

func _set_properties_attributes():
	var player_shape = RectangleShape2D.new()
	player_shape.set_size(playerSize)
	$Hitbox/CollisionShape2D.shape = player_shape
	$PlayerCollisionArea.shape = player_shape
	

func _process(_delta: float) -> void:
	if facing == Vector2.LEFT:
		$AnimationSprites.flip_h = true
	else:
		$AnimationSprites.flip_h = false

func _on_hitbox_area_entered(area: Area2D) -> void:
	var object = area.get_parent()
	if object.is_in_group('Projectile'):
		player_hit()

func player_hit():
	print('ouch')
