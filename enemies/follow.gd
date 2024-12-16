extends State

@export var speed : float
@export var pause_time : float
@export var nav_agent : NavigationAgent2D

@export var detection_area : Area2D
@export var ray_cast : RayCast2D
var player : Player

func enter():
	for body in detection_area.get_overlapping_bodies():
		if body is Player: 
			player = body
			return
	transition.emit(self, "wander")
	
func update(_delta:float):
	pass

func physics_update(_delta:float):
	nav_agent.target_position = player.global_position
	move_nav()

func move_nav():
	var current_agent_pos = actor.global_position
	var next_path_pos = nav_agent.get_next_path_position()
	var direction = current_agent_pos.direction_to(next_path_pos).normalized()
	nav_agent.velocity = direction * speed
