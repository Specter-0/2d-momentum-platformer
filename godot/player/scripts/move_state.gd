extends State

@export var ground_state : State_State_Machine 

func state_process(_delta): 
	if character.velocity.x == 0:
		next_state = ground_state.idle
