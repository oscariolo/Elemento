extends Node
@export var player: CharacterBody2D
@export var max_boost_jump_velocity: float = 800
@export var slowing_velocity_factor: float = 50
var current_boost_power: float = 0
var charging_boost = false
var just_boosted = false

func _physics_process(delta: float) -> void:
	if player.is_on_floor():
		just_boosted = false

func start_charge():
	player.velocity.y = 0
	charging_boost = true

func charge_jump():
	current_boost_power += lerp(current_boost_power,-max_boost_jump_velocity,0.1)
	if abs(current_boost_power) >= abs(max_boost_jump_velocity):
		current_boost_power = max_boost_jump_velocity
		
	
func release_jump():
	player.velocity.y -= current_boost_power
	current_boost_power = 0
	charging_boost = false
	just_boosted = true
