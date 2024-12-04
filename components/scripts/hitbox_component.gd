extends Area2D
class_name HitboxComponent

@export var damage := 10.0
@export var knockback_time := 0.25
@export var knockback_strength := 5.0

func _ready():
	area_entered.connect(_on_area_entered)

func _on_area_entered(area):
	if area is HurtboxComponent:
		var hurtbox : HurtboxComponent = area
		var attack = Attack.new()
		attack.damage = damage
		attack.knockback_time = knockback_time
		attack.knockback = (area.global_position - global_position) * knockback_strength
		hurtbox.damage(attack)
