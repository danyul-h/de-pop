extends Area2D
class_name HitboxComponent

@export var damage := 10.0
@export var knockback_time := 0.25
@export var force := 5.0

func _ready():
	area_entered.connect(_on_area_entered)

func _on_area_entered(area):
	if area is HurtboxComponent:
		var hurtbox : HurtboxComponent = area
		var attack = Attack.new()
		attack.damage = damage
		attack.knockback_time = knockback_time
		attack.force = force
		attack.velocity = get_parent().velocity.normalized() 
		attack.origin = global_position
		hurtbox.damage(attack)
