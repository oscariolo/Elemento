extends Node
var current_state: State
var states: Dictionary = {}
@export var initial_state:State
@export var animationSpritesPlayer:AnimatedSprite2D
@export var this_player:CharacterBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for state in get_children():
		if state is State:
			state.animation_player = animationSpritesPlayer
			state.player = this_player
			states[state.name.to_lower()] = state
			state.transition.connect(on_animation_transition)
	if initial_state != null:
		current_state = initial_state
		current_state.enter()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	current_state.update()

func on_animation_transition(state,new_animation_state):
	if current_state != state:
		return
	var new_state = states.get(new_animation_state.to_lower())
	if !new_state:
		return
	if current_state:
		current_state.exit()
	new_state.enter()	
	current_state = new_state
