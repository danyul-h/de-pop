extends CharacterBody2D
class_name Player

@onready var jump_cooldown : Timer = $JumpCooldown
@onready var camera : Camera2D = $Camera2D
@onready var label : Label = $Label
@onready var state_machine : StateMachine = $StateMachine
@onready var animation : AnimationPlayer = $AnimationPlayer
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

func _process(_delta):
	label.text = state_machine.current_state.name + " " + String.num($HealthComponent.health)
	var mouse_direction = get_global_mouse_position() - position
	animation_direction = ("left" if mouse_direction.x < 0 else "right") if abs(mouse_direction.x) >= abs(mouse_direction.y) else ("front" if mouse_direction.y > 0 else "back")

func _physics_process(_delta):
	velocity = movement + knockback
	move_and_slide()
