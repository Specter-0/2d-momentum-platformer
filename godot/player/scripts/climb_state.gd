extends State

@export var air_state : State_State_Machine 

func state_process(_delta):
	if character.velocity.y > air_state.maxed_interval.x: 
		next_state = air_state.peak
