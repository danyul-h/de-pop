extends PlayerState

func enter():
	actor.movement = Vector2()

func update(_delta):
	update_animation_direction("idle")
	
	if Input.get_vector("left", "right", "up", "down"): transition.emit(self, "walk")
	
	if Input.is_action_just_pressed("jump"): 
		if actor.jump_cooldown.is_stopped(): transition.emit(self, "jump")
		else: actor.camera.apply_shake(1, 10)
