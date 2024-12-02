extends PlayerState

@export var health_component : HealthComponent
@export var speed : float

func enter():
	if not health_component.hurt.is_connected(_on_hurt): health_component.hurt.connect(_on_hurt)
	if not health_component.dead.is_connected(_on_dead): health_component.dead.connect(_on_dead)

func update(delta: float):
	update_animation_direction("walk")
	
	var vector = Input.get_vector("left", "right", "up", "down")
	player.movement = vector.normalized() * speed
	
	if not vector: transition.emit(self, "idle")
	
	if Input.is_action_just_pressed("jump"): 
		if player.jump_cooldown.is_stopped(): transition.emit(self, "jump")
		else: player.camera.apply_shake(1, 10)

func _on_hurt(): transition.emit(self, "hurt")

func _on_dead(): transition.emit(self, "dead")
