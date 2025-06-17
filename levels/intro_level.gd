extends Node

func _ready() -> void:
	#Test player
	#$Player/Abilities.add_elemental_ability("Wind")
	#$Player/Abilities.add_elemental_ability("Fire")
	#$Player/Abilities.add_elemental_ability("Rock")
	#$Player/Abilities.add_elemental_ability("Water")
	pass

func _on_area_2d_area_entered(area: Area2D) -> void:
	if(!Globals.powerSelectorInstance):
		var number_of_abilites = $Player/Abilities.current_abilities.keys().size()
		if(number_of_abilites < 4): #Control to not instantiate menu unnecesarly
			var menuInstance = Globals.power_selector_menu.instantiate() as PowerSelector
			menuInstance.chosen_power.connect($Player.on_power_selector_chosen_power)
			add_child(menuInstance)
			menuInstance.availablePowers = menuInstance.availablePowers.filter(_filterAlreadyGottenPowers)
			Globals.powerSelectorInstance = menuInstance
			Globals.powerSelectorInstance.display()
	

func _filterAlreadyGottenPowers(power:String):
	var playerPowers = $Player/Abilities.current_abilities.keys() as Array 
	return !playerPowers.has(power)
