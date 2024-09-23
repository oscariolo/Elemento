extends Element
@export var shape_reduce_factor:float = 0.5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func start() -> void:
	if Input.is_action_pressed("slide"):
		movement_component.player.set_collision_mask_value(2,false)
	if Input.is_action_just_released("slide"):
		movement_component.player.set_collision_mask_value(2,true)

func on_water_phase() -> void:
	pass

func stop_water_phase() -> void:
	pass
