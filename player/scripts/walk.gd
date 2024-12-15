extends PlayerState

@export var speed : float

func update(_delta):
	update_animation_direction("walk")
	
	var vector = Input.get_vector("left", "right", "up", "down")
	actor.movement = vector.normalized() * speed
	
	if not vector: transition.emit(self, "idle")
	
	if Input.is_action_just_pressed("jump"): 
		if actor.jump_cooldown.is_stopped(): transition.emit(self, "jump")
		else: actor.camera.apply_shake(1, 10)
