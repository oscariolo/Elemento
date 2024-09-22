extends CharacterBody2D

func _physics_process(delta: float) -> void:
	if(Input.is_action_just_pressed("jump") && $PlayerMovementComponent.jumped || !is_on_floor() && Input.is_action_just_pressed("jump")):
		$Abilities/WindElementComponent.start_charge()
	
	if($Abilities/WindElementComponent.charging_boost):$Abilities/WindElementComponent.charge_jump()
	
	if(Input.is_action_just_released("jump") && $Abilities/WindElementComponent.charging_boost):
		$Abilities/WindElementComponent.release_jump()
		
	if($Abilities/WindElementComponent.charging_boost):
		$PlayerMovementComponent.set_motionless()
	else:
		$PlayerMovementComponent.set_default_motion()
