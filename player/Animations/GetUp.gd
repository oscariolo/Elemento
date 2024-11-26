extends State
class_name GetUp

func enter():
	animation_player.play('get_up')

func exit():
	animation_player.stop()

func update():
	if Input.is_action_just_pressed("jump"):
		transition.emit(self,'jump')
	if !animation_player.is_playing():
		transition.emit(self,'idle')
