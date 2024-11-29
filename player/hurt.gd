extends PlayerState

func enter():
	player.movement = Vector2(0, 0)
	player.animation.play("hurt")
