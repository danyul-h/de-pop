extends PlayerState

func enter():
	actor.movement = Vector2(0, 0)
	actor.animation.play("hurt")

func update(_delta):
	if not actor.animation.is_playing(): transition.emit(self, "idle")
