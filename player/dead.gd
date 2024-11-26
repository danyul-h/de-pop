extends PlayerState

func enter():
	player.sprite.play("dead")
	await player.sprite.animation_finished
	player.queue_free()
