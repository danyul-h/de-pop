extends Node
class_name PlayerState

var player : Player

@warning_ignore("unused_signal")
signal transition

func enter():
	pass
	
func exit():
	pass
	
func update(_delta:float):
	pass

func physics_update(_delta:float):
	pass

func update_animation_direction(animation : String):
	player.sprite.play(player.animation_direction+"_"+animation)
