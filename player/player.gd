extends CharacterBody2D
var elemental_abilities: Array[Element]

func _ready() -> void:
	$Abilities.add_elemental_ability("wind")

func _process(delta: float) -> void:
	print(velocity)

func _physics_process(delta: float) -> void:
	pass
