extends Node2D
class_name HealthComponent

@export var MAX_HEALTH := 100.0
@export var actor : Node
@export var sprite : AnimatedSprite2D
var health : float
var knockbackTween : Tween

func _ready():
	health = MAX_HEALTH

func damage(attack : Attack):
	actor.state_machine.transition("hurt")
	health -= attack.damage
	
	if actor is Player and attack.damage >= health/2:
		actor.freeze_frame(attack.knockback_time)
	
	if knockbackTween:
		knockbackTween.kill()
	
	actor.movement = Vector2()
	actor.knockback = attack.knockback
	knockbackTween = get_tree().create_tween()
	knockbackTween.parallel().tween_property(actor, "knockback", Vector2(0, 0), attack.knockback_time)
	
	sprite.modulate = Color(10, 10, 10)
	knockbackTween.parallel().tween_property(sprite, "modulate", Color(1,1,1,1), attack.knockback_time)
	
	await knockbackTween.finished
	actor.state_machine.transition("idle")
	
	if health <= 0: 
		actor.state_machine.transition("dead")
	
