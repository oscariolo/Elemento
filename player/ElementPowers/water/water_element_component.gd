extends Element
@export var shape_reduce_factor:float = 0.5
@export var player: CharacterBody2D


func load_properties(properties) -> void:
	player = properties[0].get_parent()

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("slide"):
		player.set_collision_mask_value(2,false)
	if Input.is_action_just_released("slide"):
		player.set_collision_mask_value(2,true)
