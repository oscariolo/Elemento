extends Node
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var last_x_input = [0]
var last_y_input = [0]

#GRAVITY AND HORIZONTAL MOVEMENT
const MAX_FALL_SPEED = 350.0
const MAX_WALK_SPEED = 300.0
#const acc = 50.0
#JUMP MECHANIC
@export var jump_height : float = 100
@export var jump_time_to_peak : float = 0.4
@export var jump_time_to_descent : float = 0.5
@onready var jump_velocity : float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
@onready var jump_gravity : float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
@onready var fall_gravity : float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0
var direction = 0
#jump buffer timer
var jump_timer_buffer = 0.0

@onready var player: CharacterBody2D = self.get_parent()

func _process(_delta):	
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
	
	if player.velocity.y < MAX_FALL_SPEED:
		player.velocity.y += get_currentgravity() * delta
	_walk(delta)
	
	if Input.is_action_just_pressed("jump"):
		jump_timer_buffer = 0.1
	jump_timer_buffer -= delta
	if jump_timer_buffer > 0:
		if player.is_on_floor() or $coyote_time.time_left > 0.0:
			_jump(delta)
	if Input.is_action_just_released("jump"):
		if player.velocity.y < MAX_FALL_SPEED:
			player.velocity.y = lerp(player.velocity.y,fall_gravity,0.05)
	
	var was_on_floor = player.is_on_floor()
	player.move_and_slide()
	var just_left_ledge = was_on_floor and not player.is_on_floor() and player.velocity.y >=0
	if just_left_ledge:
		$coyote_time.start()

func _walk(_delta): #TODO refactor code to not suck ass, the logic here is to make sharper turns when jumping
	var acc = 50
	if player.is_on_floor(): #acceleration change ensure speed apex
		acc = acc
	else:
		acc = acc * 2
	if last_x_input.back() == 1:
		player.velocity.x = min(player.velocity.x + acc,MAX_WALK_SPEED)	
	if last_x_input.back() == -1:
		player.velocity.x = max(player.velocity.x - acc,-MAX_WALK_SPEED)
	if last_x_input.back() == 0:
		player.velocity.x = lerp(player.velocity.x,0.0,0.4)	
			
func _jump(_delta):
	player.velocity.y = jump_velocity
	jump_timer_buffer = 0.0
	
	
func get_currentgravity() -> float:
	return jump_gravity if player.velocity.y < 0.0 else fall_gravity
	

func _on_coyote_time_timeout() -> void:
	pass # Replace with function body.
