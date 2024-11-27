extends Node

func add_elemental_ability(elemental_string: String) -> void:
	var format_string = "res://player/ElementPowers/%s/%s_element_component.tscn"
	var new_ability_path = format_string % [elemental_string,elemental_string]
	var new_ability = load(new_ability_path).instantiate() as Element
	new_ability.player = get_parent()
	add_child(new_ability)
	new_ability.load_properties()
	new_ability.connect_interactions()	
