extends State
class_name Run

func enter():
	animation_player.play('run')

func exit():
	animation_player.stop()

func update():
	if abs(player.velocity.x) == 0:
		transition.emit(self,'idle')
	if Input.is_action_just_pressed("jump"):
		transition.emit(self,'jump')
	if Input.is_action_just_pressed('slide'):
		transition.emit(self,'slide')
