extends Node2D
class_name HealthComponent

@export var MAX_HEALTH := 100.0
@export var invincibility_time := 0.1
@export var actor : CollisionObject2D
@export var sprites : Array[Sprite2D]

@export var state_machine : StateMachine

var health : float
var knockbackTween : Tween
var died := false
var invincible := false

func _ready():
	health = MAX_HEALTH

func damage(attack : Attack):
	if died or invincible: return
	set_invincible()
	
	health -= attack.damage
	state_machine.transition("hurt")
	
	actor.movement = Vector2()
	
	if actor is Player and attack.damage >= health:
		actor.freeze_frame(attack.knockback_time)
	
	if knockbackTween:
		knockbackTween.kill()
	
	actor.knockback = (actor.global_position-attack.origin) * attack.force
	
	knockbackTween = get_tree().create_tween()
	knockbackTween.parallel().tween_property(actor, "knockback", Vector2(0, 0), attack.knockback_time)
	for sprite in sprites:
		sprite.modulate = Color(30, 15, 15)
		knockbackTween.parallel().tween_property(sprite, "modulate", Color(1,1,1,1), attack.knockback_time)
	await knockbackTween.finished
	
	if health <= 0: 
		died = true
		state_machine.transition("dead")
	
func set_invincible():
	invincible = true
	await get_tree().create_timer(invincibility_time).timeout
	invincible = false
