extends CanvasLayer

func _ready() -> void:
	$MenuOptions.visible = true
	$MenuSettings.visible = false
	load_settings_preferences()

func _on_menu_options_options_pressed() -> void:
	$MenuOptions.visible = false
	$MenuSettings.visible = true
	

func _on_menu_settings_exit_settings() -> void:
	$MenuSettings.visible = false
	$MenuOptions.visible = true

func load_settings_preferences():
	var config = ConfigFile.new()
	config.load("res://settings.cfg")
	var resolution = config.get_value("Settings","Resolution", Vector2i(640,360))
	$MenuSettings.change_res_and_center(resolution)
