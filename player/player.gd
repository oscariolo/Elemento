extends CharacterBody2D

func _ready() -> void:
	$Abilities.add_elemental_ability("water")

func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	pass
