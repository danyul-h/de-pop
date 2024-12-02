extends PlayerState

func enter():
	player.movement = Vector2(0, 0)
	player.animation.play("dead")
	await player.animation.animation_finished
	player.queue_free()
