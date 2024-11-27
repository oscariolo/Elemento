extends State
class_name Slide

func enter():
	animation_player.play('slide')

func exit():
	animation_player.stop()

func update():
	if !Input.is_action_pressed('ui_left') && !Input.is_action_pressed('ui_right'):
		transition.emit(self,'idle')
	if Input.is_action_just_pressed("jump"):
		transition.emit(self,'jump')
	if !player.get_node('PlayerMovementComponent').sliding:
		transition.emit(self,'getup')
