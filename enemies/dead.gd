extends State

@export var kill_actor : Node2D
@export var nav_agent : NavigationAgent2D

func enter():
	nav_agent.velocity = Vector2()
	kill_actor.queue_free()
	
