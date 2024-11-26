extends PlayerState

func enter():
	player.movement = Vector2(0, 0)
	player.sprite.play("hit")
