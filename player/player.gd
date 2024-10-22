extends CharacterBody2D

func _ready() -> void:
	$Abilities.add_elemental_ability("water")
	$Abilities.add_elemental_ability('wind')
	$Abilities.add_elemental_ability('fire')

func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	pass
