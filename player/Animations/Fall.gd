extends State
class_name Fall

func enter():
	animation_player.play('fall')

func exit():
	animation_player.stop()

func update():
	if player.is_on_floor():
		transition.emit(self,'idle')
		
