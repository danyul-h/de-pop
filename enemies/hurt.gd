extends State

@export var speed : float
@export var nav_agent : NavigationAgent2D
@export var pause_time : float

func enter():
	nav_agent.velocity /= 2
	await get_tree().create_timer(pause_time).timeout
	transition.emit(self, "follow")
