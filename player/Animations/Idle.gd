extends State
class_name IdleState

func enter():
	animation_player.play('idle')

func exit():
	animation_player.stop()

func update():
	if Input.is_action_pressed('ui_left') || Input.is_action_pressed('ui_right'):
		transition.emit(self,'run')
	if Input.is_action_just_pressed("jump"):
		transition.emit(self,'jump')
		
