extends CharacterBody2D
var facing:Vector2 = Vector2.RIGHT
@export var playerSize:Vector2 = Vector2(19,33)
@onready var playerSizeSliding:Vector2 = Vector2(playerSize.x,playerSize.y/2)
var life:int = 1

func _ready() -> void:
	$Hitbox/CollisionShape2D.shape.size = playerSize
	$PlayerCollisionShape.shape.size = playerSize
	# "target" is the Canvas item which material contains the shader.

func _change_player_collision_to_sliding(change:bool = true):
	var collisionShape = $PlayerCollisionShape
	var shape = collisionShape.shape
	if change:
		shape.size = playerSizeSliding
		var offset = (playerSize.y - playerSizeSliding.y)/2
		collisionShape.position.y = offset
		$Hitbox/CollisionShape2D.position.y = offset
		$Hitbox/CollisionShape2D.shape.size = playerSizeSliding
	else:
		shape.size = playerSize
		collisionShape.position.y = 0
		$Hitbox/CollisionShape2D.position.y = 0
		$Hitbox/CollisionShape2D.shape.size = playerSizeSliding



func _process(_delta: float) -> void:
	
	if Input.is_action_pressed("slide") && $PlayerMovementComponent.sliding:
		_change_player_collision_to_sliding()
	else:
		_change_player_collision_to_sliding(false)
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


func on_power_selector_chosen_power(power: String) -> void:
	$Abilities.add_elemental_ability(power)
