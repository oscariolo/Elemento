extends Node

@export var player: CharacterBody2D
# Get the gravity from the project settings to be synced with RigidBody nodes.
var last_x_input = [0]
var last_y_input = [0]

#GRAVITY AND HORIZONTAL MOVEMENT
@export var MAX_FALL_SPEED = 350.0
@export var MAX_WALK_SPEED = 300.0
@export_range(0,1) var on_air_movement_modifier = 0.2
#const acc = 50.0
#JUMP MECHANIC
@export var jump_height : float = 100
@export var jump_time_to_peak : float = 0.4
@export var jump_time_to_descent : float = 0.3
var jump_velocity : float
var jump_gravity : float
var fall_gravity : float 
#jump buffer timer
var jump_timer_buffer = 0.0
#jump control
var jumped = false

func _ready() -> void:
	set_default_motion()

func _process(_delta):	
	_inputControls()

func _inputControls(): #manage the input from player holding the last input so it can press multiple keys but priorize the last one
	if Input.is_action_just_pressed("move_left"):
		if -1.0 not in last_x_input:
			last_x_input.append(-1.0)
	if Input.is_action_just_pressed("move_right"):
		if 1.0 not in last_x_input:
			last_x_input.append(1.0)
	
	if Input.is_action_just_pressed("look_up"):
		if -1.0 not in last_y_input:
			last_y_input.append(-1.0)
	if Input.is_action_just_pressed("look_down"):
		if 1.0 not in last_y_input:
			last_y_input.append(1.0)
	
	if Input.is_action_just_released("move_left"):
		last_x_input.erase(-1.0)
	if Input.is_action_just_released("move_right"):
		last_x_input.erase(1.0)
	if Input.is_action_just_released("look_up"):
		last_y_input.erase(-1.0)
	if Input.is_action_just_released("look_down"):
		last_y_input.erase(1.0)
	
func _physics_process(delta):
	
	if player.velocity.y < MAX_FALL_SPEED: #gravity gets updated given if its jumping or not
		player.velocity.y += get_currentgravity() * delta
		
	_walk_process(delta) #manages walk process with special case for on air apex change
	_jump_process(delta)
	
	

func _walk_process(_delta): 
	var on_air_modifier = 0
	if player.is_on_floor(): #acceleration change ensure speed apex
		on_air_modifier = 0
	else:
		on_air_modifier = on_air_movement_modifier
	if last_x_input.back() == 1:
		player.velocity.x = lerp(player.velocity.x, MAX_WALK_SPEED, 0.3 + on_air_modifier)
	if last_x_input.back() == -1:
		player.velocity.x = lerp(player.velocity.x,-MAX_WALK_SPEED, 0.3 + on_air_modifier)
	if last_x_input.back() == 0:
		player.velocity.x = lerp(player.velocity.x,0.0,0.4)	

func _jump_process(delta):
	if player.is_on_floor():
		jumped = false
	
	if Input.is_action_just_pressed("jump"): #checks first for a jump input right before reaching the floor
		jump_timer_buffer = 0.1
	jump_timer_buffer -= delta
	if jump_timer_buffer > 0:
		if player.is_on_floor() or $coyote_time.time_left > 0.0:
			player.velocity.y = jump_velocity
			jump_timer_buffer = 0.0
			jumped = true
	
	if Input.is_action_just_released("jump"): 
		if player.velocity.y < MAX_FALL_SPEED:
			player.velocity.y = lerp(player.velocity.y,fall_gravity,0.05)
	
	var was_on_floor = player.is_on_floor() 
	player.move_and_slide() #on next frame check if left the floor to start coyote timer
	var just_left_ledge = was_on_floor and not player.is_on_floor() and player.velocity.y >=0
	if just_left_ledge:
		$coyote_time.start()
	
	
	
func get_currentgravity() -> float:
	return jump_gravity if player.velocity.y < 0.0 else fall_gravity

func set_default_motion() -> void:
	jump_velocity  = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
	jump_gravity = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
	fall_gravity  = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0

func set_motionless() -> void:
	jump_velocity = 0
	jump_gravity = 0
	fall_gravity = 0


func _on_coyote_time_timeout() -> void:
	pass # Replace with function body.
