extends State
class_name Run

func enter():
	animation_player.play('run')

func exit():
	animation_player.stop()

func update():
	if !Input.is_action_pressed('ui_left') && !Input.is_action_pressed('ui_right'):
		transition.emit(self,'idle')
	if Input.is_action_just_pressed("jump"):
		transition.emit(self,'jump')
	if Input.is_action_just_pressed('slide'):
		transition.emit(self,'slide')
