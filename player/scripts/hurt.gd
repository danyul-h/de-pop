extends PlayerState

@export var health_component : HealthComponent

func enter():
	player.movement = Vector2(0, 0)
	player.animation.play("hurt")

func update(_delta):
	if not player.animation.is_playing(): transition.emit(self, "idle")

func _ready():
	health_component.hurt.connect(_on_hurt)
	health_component.dead.connect(_on_dead)

func _on_hurt(): transition.emit(self, "hurt")

func _on_dead(): transition.emit(self, "dead")
