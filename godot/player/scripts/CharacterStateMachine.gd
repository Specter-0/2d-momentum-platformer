extends Node

class_name CharacterStateMachine

@export var d1_currentState : State
@export var character : CharacterBody2D 

var d1_states : Array[State]


func _ready():
	for child in get_children():
		if child is State:
			d1_states.append(child)
			
			child.character = character
		else:
			push_warning("child " + child.name + " is not a state")

func _physics_process(delta):
	if d1_currentState.next_state != null:
		switch_states(d1_currentState.next_state)
		
	d1_currentState.state_process(delta)


func switch_states(new_state : State):
	d1_currentState.on_exit()
	d1_currentState.next_state = null

	d1_currentState = new_state
	d1_currentState.on_enter()


func check_if_can_move():
	return d1_currentState.can_move


func _input(event : InputEvent):
	d1_currentState.state_input(event)

 
