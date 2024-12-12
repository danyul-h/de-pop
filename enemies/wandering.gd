extends State

@export var speed : float
@export var nav_agent : NavigationAgent2D

func _ready():
	nav_agent.navigation_finished.connect(_on_nav_finished)
	nav_agent.velocity_computed.connect(_on_velocity_computed)
	call_deferred("_on_nav_finished")

func _on_velocity_computed(safe_velocity):
	actor.velocity = actor.velocity.move_toward(safe_velocity, 100)
	actor.move_and_slide()

func _on_nav_finished():
	make_path(Vector2(randf_range(actor.global_position.x-10, actor.global_position.x+10), randf_range(actor.global_position.y-10, actor.global_position.y+10)))

func make_path(pos : Vector2):
	nav_agent.target_position = pos

func physics_update(_delta:float):
	var current_agent_pos = actor.global_position
	var next_path_pos = nav_agent.get_next_path_position()
	var direction = current_agent_pos.direction_to(next_path_pos).normalized()
	nav_agent.velocity = direction * speed
