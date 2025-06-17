extends Node
var current_abilities:Dictionary = {}

func add_elemental_ability(elemental_string: String) -> void:
	if(!current_abilities.has(elemental_string)):
		var new_ability_resource: Resource
		match elemental_string:
			"Water":
				new_ability_resource = load("res://player/ElementPowers/water/water_element_component.tscn")
			"Fire":
				new_ability_resource = load("res://player/ElementPowers/fire/fire_element_component.tscn")
			"Wind":
				new_ability_resource = load("res://player/ElementPowers/wind/wind_element_component.tscn")
			"Rock":
				new_ability_resource = load("res://player/ElementPowers/rock/rock_element_component.tscn")
		
		var new_ability = new_ability_resource.instantiate() as Element
		new_ability.player = get_parent()
		add_child(new_ability)
		current_abilities.get_or_add(elemental_string,new_ability)
		new_ability.load_properties()
		new_ability.connect_interactions()	
