extends Node
class_name StateMachine

@export var intial_state : State
@export var actor : CollisionObject2D
var current_state : State
var states : Dictionary = {}

func _ready():
	for child in get_children():
		if child is not State: continue
		states[child.name.to_lower()] = child
		child.actor = actor
		child.transition.connect(on_child_transition)
	if intial_state:
		intial_state.enter()
		current_state = intial_state

func _process(delta):
	if current_state: current_state.update(delta)

func _physics_process(delta):
	if current_state: current_state.physics_update(delta)

func on_child_transition(state, new_state_name):
	if state != current_state: return #if the state transition calling transition is not current state, return
	transition(new_state_name)

func transition(new_state_name):
	var new_state = states.get(new_state_name.to_lower()) #get new state from name
	if !new_state: return #if new state doesnt exist, return
	
	if current_state: current_state.exit() #if theres a current state, exit it
	new_state.enter() #enter new state
	current_state = new_state #set new state to current state
