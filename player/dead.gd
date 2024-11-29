extends PlayerState

func enter():
	player.animation.play("dead")
	await player.animation.animation_finished
	player.queue_free()
