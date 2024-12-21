extends Control

func _ready() -> void:
	for button:Button in $MenuOptions.get_children():
		button.connect("mouse_entered",on_button_hovered.bind(button.name))
		button.connect("mouse_exited",on_button_exited.bind(button.name))


func _on_new_game_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/intro_level.tscn")

func _on_exit_pressed() -> void:
	get_tree().quit()


func on_button_hovered(buttonName:String):
	var buttonNode = get_node("MenuOptions".path_join(buttonName))
	var currentButtonStyleBox = buttonNode.get_theme_stylebox("hover","Button") as StyleBoxFlat
	var overrideStyleBox = currentButtonStyleBox.duplicate(true) as StyleBoxFlat
	overrideStyleBox.border_width_left -= 30
	buttonNode.add_theme_stylebox_override("hover",overrideStyleBox)

func on_button_exited(buttonName:String):
	get_node("MenuOptions".path_join(buttonName)).remove_theme_stylebox_override("hover")
