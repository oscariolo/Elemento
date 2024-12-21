extends ColorRect
@onready var target = self
# "target" is the Canvas item which material contains the shader.
func _ready() -> void:
	set_shader_params()
func set_shader_params() -> void:
	pass

func _process(delta: float) -> void:
	pass
