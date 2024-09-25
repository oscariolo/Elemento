extends CharacterBody2D
var on_phase_wall = false
var hitbox_body: Node2D

func _ready() -> void:
	$Abilities.add_elemental_ability("water")

func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	pass
