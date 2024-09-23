extends Element
@export var max_boost_jump_velocity: float = 800
var min_boost_jump: float = 500
@export var slowing_velocity_factor: float = 50
var current_boost_power: float = 0
var charging_boost = false
var has_boosted = false
@export var velocity_x_reduce: float  = 0.5


func start() -> void:
	if movement_component.player.is_on_floor():
		has_boosted = false
	
	if !has_boosted: #check wether has boosted before can only once
		if !movement_component.can_coyote_jump:  #check if didnt try a coyote jump or was just about touching the floor
			if Input.is_action_just_pressed("jump") && movement_component.jumped && !movement_component.is_jumping: #checks for a double jump hence must have jumped and has released the basic jump
				start_charge()
		
	
	if Input.is_action_pressed("jump") && charging_boost:
		charge_jump()
	
	if Input.is_action_just_released("jump") && charging_boost:
		release_jump()

func start_charge():
	charging_boost = true

func charge_jump():
	movement_component.set_motionless()
	current_boost_power += lerp(current_boost_power,max_boost_jump_velocity,0.1)
	if current_boost_power >= max_boost_jump_velocity:
		current_boost_power = max_boost_jump_velocity
	
	
		
	
func release_jump():
	if current_boost_power >= min_boost_jump:
		movement_component.player.velocity.y -= current_boost_power
	else:
		movement_component.player.velocity.y -= min_boost_jump
	current_boost_power = 0
	charging_boost = false
	has_boosted = true
	movement_component.set_default_motion()
	
