extends CharacterBody2D

func _physics_process(delta: float) -> void:
	if(Input.is_action_just_pressed("jump") && $PlayerMovementComponent.jumped || !is_on_floor() && Input.is_action_just_pressed("jump")):
		if(!$Abilities/WindElementComponent.just_boosted):
			$Abilities/WindElementComponent.start_charge()
	
	if($Abilities/WindElementComponent.charging_boost):$Abilities/WindElementComponent.charge_jump()
	
	if(Input.is_action_just_released("jump") && $Abilities/WindElementComponent.charging_boost):
		$Abilities/WindElementComponent.release_jump()
		
	if($Abilities/WindElementComponent.charging_boost):
		$PlayerMovementComponent.set_motionless()
	else:
		$PlayerMovementComponent.set_default_motion()
##Maybe its better to have the ability controller in the abilities node, from there we coul call signals to show sprites in player, but then player script doesnt hold much (which maybe is good?)
##The logic that the base character has since its the base, maybe it was unnecessary to have the movement component, i will not use it anywhere else except maybe enemies but even then seems overkill
##by having the movement on the player the advantage is seemless not much
