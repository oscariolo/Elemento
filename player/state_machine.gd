extends Node

var states : Dictionary = {}
var current_state : State
@export var initial_state : State

func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.transition_from_to.connect(on_child_transition)
	
	if initial_state:
		current_state = initial_state
		current_state.enter()

func _process(delta: float) -> void:
	current_state.update(delta)

func on_child_transition(state:State, new_state_name:String):
	if state != current_state:
		return
		
	var new_state = states.get(new_state_name.to_lower())
	
	if !new_state:
		return
		
	if current_state:
		current_state.exit()
		
	current_state = new_state
	
	current_state.enter()
		
