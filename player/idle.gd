extends PlayerState

func enter():
	player.movement = Vector2()

func update(delta: float):
	update_animation_direction("idle")
	
	if Input.get_vector("left", "right", "up", "down"): transition.emit(self, "walk")
	
	if Input.is_action_just_pressed("jump"): 
		if player.jump_cooldown.is_stopped(): transition.emit(self, "jump")
		else: player.camera.apply_shake(1, 10)
