extends ColorRect

var backgroundMaterial: ShaderMaterial
var fireColor: Color = Color(0.5, 0, 0, 1)
var waterColor: Color = Color(0, 0, 0.5, 1)
var windColor: Color = Color(0, 0.5, 0, 1)
var rockColor: Color = Color(0.5, 0.5, 0.5, 1)

var colors: Array = []
var current_color_index: int = 0
var next_color_index: int = 1
var transition_time: float = 5.0
var elapsed_time: float = 0.0

func _ready() -> void:
	backgroundMaterial = material
	colors = [fireColor, waterColor, windColor, rockColor]

func _process(delta: float) -> void:
	elapsed_time += delta
	var t = elapsed_time / transition_time
	if t >= 1.0:
		t = 0.0
		elapsed_time = 0.0
		current_color_index = next_color_index
		next_color_index = (next_color_index + 1) % colors.size()
	
	var current_color = colors[current_color_index] as Color
	var next_color = colors[next_color_index]
	var interpolated_color = current_color.lerp(next_color, t)
	backgroundMaterial.set_shader_parameter("bottom_color", interpolated_color)
	backgroundMaterial.set_shader_parameter("top_color", interpolated_color.darkened(0.8))
