extends State

@export var speed : float
@export var nav_agent : NavigationAgent2D

@export var view_curve : Curve
@export var view_range : float

@export var dist_min : int
@export var dist_range : int

func _ready():
	nav_agent.navigation_finished.connect(make_path)
	call_deferred("make_path")

func make_path():
	await get_tree().create_timer(0.2).timeout
	var theta = view_curve.sample_baked(randf()) + nav_agent.velocity.angle() - view_curve.max_value / 2
	var r = sqrt(randf()) * dist_range + dist_min
	nav_agent.target_position = actor.global_position + Vector2(r*cos(theta), r*sin(theta))

func physics_update(_delta:float):
	var current_agent_pos = actor.global_position
	var next_path_pos = nav_agent.get_next_path_position()
	var direction = current_agent_pos.direction_to(next_path_pos).normalized()
	nav_agent.velocity = direction * speed

func exit():
	nav_agent.navigation_finished.disconnect(make_path)
