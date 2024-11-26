extends CharacterBody2D
class_name Player

@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var jump_cooldown : Timer = $JumpCooldown
@onready var camera : Camera2D = $Camera2D
@onready var label : Label = $Label
@onready var state_machine : PlayerStateMachine = $StateMachine
var movement : Vector2
var knockback : Vector2
var animation_direction := "front"

func freeze_frame(duration):
	Engine.time_scale = 0.05
	await get_tree().create_timer(duration, true, false, true).timeout
	Engine.time_scale = 1

func _ready():
	movement = Vector2(0, 0)
	knockback = Vector2(0, 0)

func _process(delta):
	var mouse_direction = get_global_mouse_position() - position
	animation_direction = ("left" if mouse_direction.x < 0 else "right") if abs(mouse_direction.x) >= abs(mouse_direction.y) else ("front" if mouse_direction.y > 0 else "back")

func _physics_process(delta):
	velocity = movement + knockback
	move_and_slide()
