extends PlayerState

@export var health_component : HealthComponent
@export var speed : float
var cooldown : Timer

var direction_to_vector = {
	"front" : Vector2(0, 1),
	"back" : Vector2(0, -1),
	"right" : Vector2(1, 0),
	"left" : Vector2(-1, 0)
}

func enter():
	player.animation.play(player.animation_direction+"_jump")
	if not player.movement: player.movement = direction_to_vector[player.animation_direction] * speed
	else: player.movement = player.movement.normalized() * speed

func update(_delta):
	if not player.animation.is_playing(): transition.emit(self, "idle")

func exit():
	player.movement = Vector2()
	player.jump_cooldown.start()

func _ready():
	health_component.hurt.connect(_on_hurt)
	health_component.dead.connect(_on_dead)

func _on_hurt(): transition.emit(self, "hurt")

func _on_dead(): transition.emit(self, "dead")