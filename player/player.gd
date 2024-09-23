extends CharacterBody2D
var elemental_abilities: Array[Element]

func _ready() -> void:
	for ability in $Abilities.get_children():
		elemental_abilities.append(ability)

func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	for ability in elemental_abilities:
		ability.start()
