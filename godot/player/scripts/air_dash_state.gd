extends State

@export var air_state : State_State_Machine 


func on_enter():
	character.collision_shape.shape = character.dash_collision_shape[0]
	character.collision_shape.position = character.dash_collision_shape[1]
	if character.dash_cooldown.is_stopped():
		dash()


func state_process(_delta):
	if dash_is_done():
		next_state = air_state.fall
	
	dash_deaccelration(_delta)
