extends State

@export var speed : float
@export var nav_agent : NavigationAgent2D

@export var view_range : float

@export var dist_min : int
@export var dist_range : int

func _ready():
	nav_agent.navigation_finished.connect(make_path)
	nav_agent.velocity_computed.connect(_on_velocity_computed)
	call_deferred("make_path")

func _on_velocity_computed(safe_velocity):
	actor.velocity = actor.velocity.move_toward(safe_velocity, speed)
	actor.move_and_slide()

func make_path():
	var theta = randf() * view_range + nav_agent.velocity.angle() - view_range / 2
	var r = sqrt(randf()) * dist_range + dist_min
	nav_agent.target_position = actor.global_position + Vector2(r*cos(theta), r*sin(theta))

func physics_update(_delta:float):
	var current_agent_pos = actor.global_position
	var next_path_pos = nav_agent.get_next_path_position()
	var direction = current_agent_pos.direction_to(next_path_pos).normalized()
	nav_agent.velocity = direction * speed
