extends Node2D
@export var output: Vector2 = Vector2.LEFT
const fireball = preload("res://hazards/FireBall/fire_ball.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$EmitionCooldown.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_emition_cooldown_timeout() -> void:
	var new_fireball = fireball.instantiate()
	new_fireball.direction = output
	new_fireball.global_position = global_position
	get_parent().add_child(new_fireball)
	
	
