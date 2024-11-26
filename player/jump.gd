extends PlayerState

@export var speed := 160

var direction_to_vector = {
	"front" : Vector2(0, 1),
	"back" : Vector2(0, -1),
	"right" : Vector2(1, 0),
	"left" : Vector2(-1, 0)
}

func enter():
	player.sprite.play(player.animation_direction+"_jump")
	if not player.movement: player.movement = direction_to_vector[player.animation_direction] * speed
	else: player.movement = player.movement.normalized() * speed
	
func update(delta: float):
	if not player.sprite.is_playing() or not player.movement: transition.emit(self, "idle")

func exit():
	player.jump_cooldown.start()
