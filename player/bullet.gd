extends CharacterBody2D
class_name Bullet

@export var speed : float
var direction : Vector2

func _ready():
	pass

func _physics_process(delta):
	velocity = direction * speed
	look_at(velocity)
	move_and_slide()
