extends State

@export var speed : float
@export var pause_time : float
@export var nav_agent : NavigationAgent2D

@export var view_curve : Curve

@export var dist_min : int
@export var dist_range : int

@export var detection_area : Area2D

func enter():
	nav_agent.navigation_finished.connect(make_path)
	detection_area.body_entered.connect(_on_body_entered)
	call_deferred("make_path")

func physics_update(_delta:float):
	var current_agent_pos = actor.global_position
	var next_path_pos = nav_agent.get_next_path_position()
	var direction = current_agent_pos.direction_to(next_path_pos).normalized()
	nav_agent.velocity = direction * speed

func _on_body_entered(body):
	if body is Player: transition.emit(self, "follow")

func make_path():
	await get_tree().create_timer(pause_time).timeout
	var theta = view_curve.sample_baked(randf()) + nav_agent.velocity.angle() - view_curve.max_value / 2
	var r = sqrt(randf()) * dist_range + dist_min
	nav_agent.target_position = actor.global_position + Vector2(r*cos(theta), r*sin(theta))

func exit():
	nav_agent.velocity = Vector2()
	nav_agent.navigation_finished.disconnect(make_path)
	detection_area.body_entered.disconnect(_on_body_entered)
