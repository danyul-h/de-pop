extends PlayerState

@export var speed := 100

func update(delta: float):
	update_animation_direction("walk")
	
	var vector = Input.get_vector("left", "right", "up", "down")
	player.movement = vector.normalized() * speed
	
	if not vector: transition.emit(self, "idle")
	
	if Input.is_action_just_pressed("jump"): 
		if player.jump_cooldown.is_stopped(): transition.emit(self, "jump")
		else: player.camera.apply_shake(1, 10)
