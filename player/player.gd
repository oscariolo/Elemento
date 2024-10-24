extends CharacterBody2D
var facing:Vector2 = Vector2.RIGHT


func _ready() -> void:
	$Abilities.add_elemental_ability("water")
	$Abilities.add_elemental_ability('wind')
	$Abilities.add_elemental_ability('fire')

func _process(delta: float) -> void:
	if facing == Vector2.LEFT:
		$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.flip_h = false
	

func _physics_process(delta: float) -> void:
	pass
