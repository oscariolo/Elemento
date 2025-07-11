extends Control
class_name PowerSelector
signal chosen_power(power:String)
@export var powersButtonContent:Dictionary = {
	"Fire": load("res://player/assets/fire.png"),
	"Water": load("res://player/assets/fire.png"),
	"Rock": load("res://player/assets/fire.png"),
	"Wind": load("res://player/assets/fire.png"),
}
var availablePowers:Array
var powerButton_resource = preload("res://Menus/buttonpower.tscn")

func _ready()->void:
	availablePowers = powersButtonContent.keys()

func display()->void:
	for power in availablePowers:
		var new_button = powerButton_resource.instantiate() as Button
		new_button.set_power_text(power)
		new_button.pressed.connect(_on_button_pressed.bind(power))
		$BoxContainer.add_child(new_button)

func _process(_delta: float) -> void:
	pass

func _on_button_pressed(power:String):
	chosen_power.emit(power)
	queue_free()
	Globals.powerSelectorInstance = null
