extends Node

class_name State_State_Machine

@export var can_move : bool = true 
@export var character : Player 
@export var currentState : State

var next_state : State_State_Machine


func state_process(_delta):
	pass


func state_input(_event : InputEvent):
	pass


func on_enter():
	pass


func on_exit():
	pass


var states : Array[State]


func _ready():
	can_move = currentState.can_move
	for child in get_children():
		if child is State:
			states.append(child)
			
			child.character = character
		else:
			push_warning("child " + child.name + " is not a state")

func current_state_process(_delta):
	if currentState.next_state != null:
		current_switch_states(currentState.next_state)
	
	currentState.state_process(_delta)


func current_switch_states(new_state : State):
	currentState.on_exit()
	currentState.next_state = null

	currentState = new_state
	currentState.on_enter()
	can_move = currentState.can_move


func current_state_input(event : InputEvent):
	currentState.state_input(event)


func check_if_can_move():
	return currentState.can_move


func current_state_methods(_delta):
	currentState.state_methods(_delta)


func direction():
	return Input.get_vector("left", "right", "up", "down")
