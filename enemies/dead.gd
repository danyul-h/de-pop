extends State

@export var speed : float
@export var nav_agent : NavigationAgent2D

func enter():
	nav_agent.velocity = Vector2()
	actor.queue_free()
