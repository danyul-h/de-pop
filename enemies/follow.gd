extends State

@export var speed : float
@export var pause_time : float
@export var nav_agent : NavigationAgent2D

@export var detection_area : Area2D
@export var ray_cast : RayCast2D
@export var chase_timer : Timer
var player : Player

func enter():
	chase_timer.timeout.connect(on_chase_timeout)
	
	for body in detection_area.get_overlapping_bodies():
		if body is Player: 
			player = body
			return
	
func update(_delta:float):
	if not player: transition.emit(self, "wander")
	if ray_cast.is_colliding():
		var collider = ray_cast.get_collider()
		if collider == player:
			chase_timer.stop()
			return
	if chase_timer.is_stopped(): chase_timer.start()

func on_chase_timeout(): 
	transition.emit(self, "wander")

func physics_update(_delta:float):
	if is_instance_valid(player): nav_agent.target_position = player.global_position
	move_nav()

func exit():
	chase_timer.timeout.disconnect(on_chase_timeout)

func move_nav():
	var current_agent_pos = actor.global_position
	var next_path_pos = nav_agent.get_next_path_position()
	var direction = current_agent_pos.direction_to(next_path_pos).normalized()
	nav_agent.velocity = direction * speed
