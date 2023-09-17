extends State

@export var air_state : State_State_Machine 

func on_enter():
	character.velocity.x = 1000
	character.velocity.y = -500


func state_process(_delta):
	character.velocity.x = clamp(character.velocity.x, -1000, 1000)
	
	if character.velocity.y > air_state.maxed_interval.y: 
		next_state = air_state.fall
	elif character.velocity.y < air_state.maxed_interval.x: 
		next_state = air_state.climb
