extends State
class_name Jump

func enter():
	animation_player.play('jump')

func exit():
	animation_player.stop()

func update():
	if Input.is_action_just_released("jump") || player.velocity.y > 0:
		transition.emit(self,'fall')
	
