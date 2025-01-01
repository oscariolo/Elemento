extends CanvasLayer

func _ready() -> void:
	$MenuOptions.visible = true
	$MenuSettings.visible = false

func _on_menu_options_options_pressed() -> void:
	$MenuOptions.visible = false
	$MenuSettings.visible = true
	


func _on_menu_settings_exit_settings() -> void:
	$MenuSettings.visible = false
	$MenuOptions.visible = true
