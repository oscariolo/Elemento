extends Button

func _ready() -> void:
	pass

func set_power_text(text:String)->void:
	$Content/VBoxContainer/PowerText.text = text
