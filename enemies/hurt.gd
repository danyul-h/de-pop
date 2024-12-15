extends State

@export var nav_agent : NavigationAgent2D

func enter():
	nav_agent.velocity = Vector2()
	await get_tree().create_timer(0.2).timeout
	transition.emit(self, "wandering")
