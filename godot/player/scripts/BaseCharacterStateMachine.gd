extends Node

class_name BaseCharacterStateMachine

@export var currentState : State_State_Machine
@export var character : Player

var states : Array[State]


func _ready():
	for child in get_children():
		if child is State:
			states.append(child)
			
			child.character = character
		else:
			push_warning("child " + child.name + " is not a state")


func _physics_process(delta):
	if currentState.next_state != null:
		switch_states(currentState.next_state)
	
	currentState.state_process(delta)


func switch_states(new_state : State_State_Machine):
	currentState.on_exit()
	currentState.next_state = null

	currentState = new_state
	currentState.on_enter()


func _input(event : InputEvent):
	currentState.state_input(event)


func check_if_can_move():
	return currentState.can_move
