extends CharacterBody2D
class_name Segment

@onready var hurtbox : HurtboxComponent = $HurtboxComponent
@onready var hitbox : HitboxComponent = $HitboxComponent
@onready var sprite : Sprite2D = $Sprite2D
var movement := Vector2()
var knockback := Vector2()

func _process(_delta):
	velocity = movement + knockback
	move_and_slide()
