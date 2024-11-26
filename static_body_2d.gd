extends Area2D

func _on_area_entered(area):
	if area is HurtboxComponent:
		var hurtbox : HurtboxComponent = area
		var attack = Attack.new()
		attack.damage = 20
		attack.knockback_time = 0.25
		attack.knockback = (area.global_position - global_position) * 5
		hurtbox.damage(attack)
