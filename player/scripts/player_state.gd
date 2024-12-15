extends State
class_name PlayerState

@warning_ignore("unused_signal")

func enter():
	pass
	
func exit():
	pass
	
func update(_delta:float):
	pass

func physics_update(_delta:float):
	pass

func update_animation_direction(animation : String):
	actor.animation.play(actor.animation_direction+"_"+animation)
