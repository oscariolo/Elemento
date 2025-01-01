extends VBoxContainer
signal exit_settings

func _on_check_box_pressed() -> void:
	if $FullScreen/CheckBox.button_pressed:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)


func _on_option_button_item_selected(index: int) -> void:
	var window = get_viewport().get_window() as Window
	match index:
		0: window.size = Vector2i(1920,1080)
		1: window.size = Vector2i(1366,768)
		2: window.size = Vector2i(1280,720)


func _on_button_pressed() -> void:
	exit_settings.emit()
