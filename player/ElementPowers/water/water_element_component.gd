extends Element
@export var shape_reduce_factor:float = 0.5
@export var player: CharacterBody2D
var pull_out_speed: float = 1000
var out_direction: Vector2
var water_sliding:bool = false
var inside_phasable_wall:bool = false


func load_properties(properties) -> void:
	player = properties[0].get_parent()
	connect_phasable_walls_signals()

func connect_phasable_walls_signals():
	for wall in get_tree().get_nodes_in_group("PhaseWall"):
		wall.connect("relative_position",set_out_direction)
		wall.connect("body_left",_on_body_left)

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("slide"):
		player.set_collision_mask_value(2,false)
		water_sliding = true
	if Input.is_action_just_released("slide"):
		water_sliding = false	
	_check_inside_collision()

func _check_inside_collision() -> void:
	if !water_sliding && inside_phasable_wall:
		player.velocity = out_direction * pull_out_speed
	if !inside_phasable_wall && !water_sliding:
		player.set_collision_mask_value(2,true)
		

func set_out_direction(wall_position:Vector2) -> void:
	out_direction = (wall_position - player.global_position).normalized() as Vector2
	inside_phasable_wall = true
	

func _on_body_left() -> void:
	out_direction = Vector2.ZERO	
	inside_phasable_wall = false
	
