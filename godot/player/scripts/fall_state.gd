extends State

@export var air_state : State_State_Machine

func state_process(_delta):
	if character.velocity.y <= 0:
		next_state = air_state.climb
