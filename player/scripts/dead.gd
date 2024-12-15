extends PlayerState

func enter():
	actor.movement = Vector2(0, 0)
	actor.animation.play("dead")
	await actor.animation.animation_finished
	actor.queue_free()
