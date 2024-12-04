extends PlayerState

@export var health_component : HealthComponent
@export var speed : float

func update(_delta):
	update_animation_direction("walk")
	
	var vector = Input.get_vector("left", "right", "up", "down")
	player.movement = vector.normalized() * speed
	
	if not vector: transition.emit(self, "idle")
	
	if Input.is_action_just_pressed("jump"): 
		if player.jump_cooldown.is_stopped(): transition.emit(self, "jump")
		else: player.camera.apply_shake(1, 10)

func _ready():
	health_component.hurt.connect(_on_hurt)
	health_component.dead.connect(_on_dead)

func _on_hurt(): transition.emit(self, "hurt")

func _on_dead(): transition.emit(self, "dead")
