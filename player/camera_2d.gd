extends Camera2D

var rng = RandomNumberGenerator.new()
var shake_strength := float(0)
var shakeFade:= float(0);

func apply_shake(strength : float, fade : float):
	shake_strength = strength;
	shakeFade = fade;

func _process(delta):	
	if shake_strength > 0:
		shake_strength = lerp(shake_strength, 0.0, shakeFade * delta)
		offset = randomOffset()

func randomOffset() -> Vector2:
	return Vector2(rng.randf_range(-shake_strength, shake_strength), rng.randf_range(-shake_strength, shake_strength))
