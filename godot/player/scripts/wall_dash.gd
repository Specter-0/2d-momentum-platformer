extends State

@export var wall_state : State_State_Machine 

func on_enter():
	if character.dash_cooldown.is_stopped():
		dash()


func state_process(_delta):
	if dash_is_done():
		wall_state.next_state = wall_state.air_state
	
	dash_deaccelration(_delta)
