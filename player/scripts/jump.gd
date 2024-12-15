extends PlayerState

@export var speed : float
var cooldown : Timer

var direction_to_vector = {
	"front" : Vector2(0, 1),
	"back" : Vector2(0, -1),
	"right" : Vector2(1, 0),
	"left" : Vector2(-1, 0)
}

func enter():
	actor.animation.play(actor.animation_direction+"_jump")
	if not actor.movement: actor.movement = direction_to_vector[actor.animation_direction] * speed
	else: actor.movement = actor.movement.normalized() * speed

func update(_delta):
	if not actor.animation.is_playing(): transition.emit(self, "idle")

func exit():
	actor.movement = Vector2()
	actor.jump_cooldown.start()
