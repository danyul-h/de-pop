extends Area2D
class_name HurtboxComponent

@export var health_component : HealthComponent
@export var invincible_duration : float
var invincible := false

func damage(attack : Attack): 
	if health_component and not invincible: 
		health_component.damage(attack)
		invincible = true
		await get_tree().create_timer(invincible_duration).timeout
		invincible = false
