extends VBoxContainer
signal exit_settings

var resolution_dict = {
	"1920 x 1080": Vector2i(1920,1080),
	"1366 x 768": Vector2i(1366,768),
	"1280 x 720": Vector2i(1280,720),
	"640 x 360": Vector2i(640,360)
	}

func _ready() -> void:
	for resolution in resolution_dict.keys():
		$Resolution/OptionButton.add_item(resolution)
	var config = ConfigFile.new()
	config.load("res://settings.cfg")
	var current_resolution = config.get_value("Settings","Resolution",Vector2i(640,320))
	var index = resolution_dict.values().find(current_resolution)
	$Resolution/OptionButton.select(index)

func _on_check_box_pressed() -> void:
	if $FullScreen/CheckBox.button_pressed:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)


func _on_option_button_item_selected(index: int) -> void:
	var resolution = resolution_dict.values()[index]
	save_resolution_preference(resolution)
	change_res_and_center(resolution)

func _on_button_pressed() -> void:
	exit_settings.emit()

func save_resolution_preference(resolution: Vector2i):
	var config = ConfigFile.new()
	config.set_value("Settings","Resolution",resolution)
	config.save("res://settings.cfg")

func change_res_and_center(resolution:Vector2i):
	DisplayServer.window_set_size(resolution)
	
	var centre_screen = DisplayServer.screen_get_position() + DisplayServer.screen_get_size()/2
	var window_size = get_window().get_size_with_decorations()
	get_window().set_position(centre_screen - window_size/2 )
