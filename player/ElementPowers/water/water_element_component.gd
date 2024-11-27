extends Element
@export var shape_reduce_factor:float = 0.5
var pull_out_speed: float = 500
var out_direction: Vector2
var wall_reference_position: Vector2 = Vector2.ZERO
var water_sliding:bool = false
var inside_phasable_wall:bool = false


func connect_interactions()-> void:
	connect_phasable_walls_signals()
	
func connect_phasable_walls_signals():
	for wall in get_tree().get_nodes_in_group("PhaseWall"):
		wall.connect("relative_position",set_out_direction)
		wall.connect("body_left",_on_body_left)

func _physics_process(_delta: float) -> void:
	
	if Input.is_action_pressed("slide"):
		player.set_collision_mask_value(2,false)
		water_sliding = true
	if Input.is_action_just_released("slide"):
		if player.global_position.x >= wall_reference_position.x:
			out_direction = Vector2(1,0)
		else:
			out_direction = Vector2(-1,0)
		water_sliding = false	
	_check_inside_collision()

func _check_inside_collision() -> void:
	if !water_sliding && inside_phasable_wall:
		player.velocity = out_direction * pull_out_speed
	if !inside_phasable_wall && !water_sliding:
		player.set_collision_mask_value(2,true)
		

func set_out_direction(wall_position:Vector2) -> void:
	wall_reference_position = wall_position
	inside_phasable_wall = true
	

func _on_body_left() -> void:
	out_direction = Vector2.ZERO	
	inside_phasable_wall = false
	
