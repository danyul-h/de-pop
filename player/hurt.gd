extends PlayerState

@export var health_component : HealthComponent

func enter():
	if not health_component.hurt.is_connected(_on_hurt): health_component.hurt.connect(_on_hurt)
	if not health_component.dead.is_connected(_on_dead): health_component.dead.connect(_on_dead)
	
	player.movement = Vector2(0, 0)
	player.animation.play("hurt")

func update(delta):
	if not player.animation.is_playing(): transition.emit(self, "idle")

func _on_hurt(): transition.emit(self, "hurt")

func _on_dead(): transition.emit(self, "dead")
